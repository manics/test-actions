const fs = require('fs/promises');
const { exec } = require('child_process');
const util = require('util');

// Promisify the exec function
const execPromise = util.promisify(exec);

const directoriesToRemove = [
  '/usr/local/lib/android',
  '/usr/local/.ghcup',
  '/opt/hostedtoolcache/CodeQL',
  '/opt/microsoft/',
  '/usr/local/share',
  '/usr/share/swift/',
];

async function getFreeDiskSpaceMB(path) {
  const stat = await fs.statfs(path);
  const availableMB = Math.floor(stat.bsize * stat.bavail / 1000000)
  console.log(`Available disk space on ${path}: ${availableMB} MB`)
  return availableMB;
}

async function deleteDirectories(directories) {
  let errors = 0;
  for (const dirPath of directories) {
    console.log(`Deleting: ${dirPath}`);
    try {
      await fs.rm(dirPath, { recursive: true, force: true });
    } catch (error) {
      // Handle errors, e.g., directory not found, permission issues
      if (error.code === 'ENOENT') {
        console.warn(`Directory not found: ${dirPath}`);
        errors += 1
      } else if (error.code === 'EPERM' || error.code === 'EACCES') {
        console.error(`Permission denied: ${dirPath}`);
        errors += 1
      } else {
        console.error(`Error removing ${dirPath}:`, error);
        errors += 1
      }
    }
  }
}

async function createZeroFile(path, sizeMB) {
  chunkMB = 1000000;
  const zeroBuffer = Buffer.alloc(chunkMB, 0); // Fills with 0 by default
  let written = 0;

  let fileHandle = await fs.open(path, 'w');
  try {
    while (written < sizeMB) {
      const { bytesWritten: writtenThisIteration } = await fileHandle.write(zeroBuffer, 0, chunkMB);
      if (writtenThisIteration != chunkMB) {
        throw new Error("Failed to write chunk");
      }
      written += 1
    }
    await fileHandle.sync();
  } finally {
    await fileHandle.close();
  }
}

async function setGithubOutput(name, value) {
  const githubOutputPath = process.env.GITHUB_OUTPUT;
  if (!githubOutputPath) {
    throw new Error('GITHUB_OUTPUT environment variable not found');
  }
  await fs.appendFile(githubOutputPath, `${name}=${value}\n`);
}

async function fsSync() {
  console.log('Global filesystem sync');
  const { stdout, stderr } = await execPromise('sync');
  if (stdout) console.log('sync stdout:', stdout);
  if (stderr) console.error('sync stderr:', stderr);
}

async function main() {
  // arg0:node arg1:script
  const args = process.argv.slice(2);

  if (args.length != 2) {
    console.log('Usage: node your_script_name.js <file_path> <size_in_mb>');
    process.exit(1);
  }
  const fileName = args[0];
  const desiredAvailableMB = parseInt(args[1]);

  let availableMB = await getFreeDiskSpaceMB("/");
  if (availableMB < desiredAvailableMB) {
    await deleteDirectories(directoriesToRemove);
    availableMB = await getFreeDiskSpaceMB("/");
  }

  const fillerMB = availableMB - desiredAvailableMB;
  if (fillerMB < 0) {
    console.error(`Available space ${desiredAvailableMB} is less then desired`);
  } else {
    console.log(`Creating ${fillerMB} MB filler file`);
    createZeroFile(fileName, fillerMB);
  }

  await fsSync();
  availableMB = await getFreeDiskSpaceMB("/");
  setGithubOutput("available-space", availableMB)
}

main()
