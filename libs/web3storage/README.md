# Web3.Storage

## About
* Store big files (for NFT, etc.) using this lib into IPFS.
* It can be done using any language: Python, JS, Rust.

## Installation
* Node & npm
* Check using `node --version && npm --version`
* If not latest, then update via `sudo n latest`

## Getting started
Follow the steps:

1. Go to this [link](https://web3.storage/) & login using Github.
1. Create a API token [here](https://web3.storage/new-token/). View all the API tokens [here](https://web3.storage/tokens/).
1. Create a file `put_files.js` & copy paste this:
```
import process from 'process'
import minimist from 'minimist'
import { Web3Storage, getFilesFromPath } from 'web3.storage'

async function main () {
  const args = minimist(process.argv.slice(2))
  const token = args.token

  if (!token) {
    return console.error('A token is needed. You can create one on https://web3.storage')
  }

  if (args._.length < 1) {
    return console.error('Please supply the path to a file or directory')
  }

  const storage = new Web3Storage({ token })
  const files = []

  for (const path of args._) {
    const pathFiles = await getFilesFromPath(path)
    files.push(...pathFiles)
  }

  console.log(`Uploading ${files.length} files`)
  const cid = await storage.put(files)
  console.log('Content added with CID:', cid)
}

main()
```
1. Create a file `package.json` & copy paste this:
```
{
    "name": "web3-storage-quickstart",
    "version": "0.0.0",
    "private": true,
    "description": "Get started using web3.storage in Node.js",
    "type": "module",
    "scripts": {
        "test": "echo \"Error: no test specified\" && exit 1"
    },
    "dependencies": {
        "minimist": "^1.2.5",
        "web3.storage": "^3.1.0"
    },
    "author": "YOUR NAME",
    "license": "(Apache-2.0 AND MIT)"
}
```
1. Open terminal in the root directory & run `npm install`.
1. Copy the API key (created before) & paste onto the command in the terminal & the files to be uploaded.
```
node put-files.js --token=<API_key> ./bike.jpeg ./car.png ./file1.txt
```
1. Get like this:
```
Uploading 3 files
Content added with CID: bafybeia4o32p72eutefiqrqu7qkcnt5g63l2x5o4kthairyogxcwxc2dum
```
1. View the images like this:
	- Bike: https://bafkreidwobteglvoqcsmucskdacrr5mnqc2caqq2pn5rygnv7x3x2hd5te.ipfs.dweb.link
	- Car: https://bafybeieh3726ksrp2i2p3ox6cg3odfttmg45jzvyfvx4gnte3egfmqciim.ipfs.dweb.link
	- file1: https://bafkreidytbk2lsdfrnomori3cfsbnlzegfizovge4elufxgxe52s6l7tmy.ipfs.dweb.link

## References
* [Quickstart](https://docs.web3.storage/#quickstart)
* [Documentation](https://docs.web3.storage/)
* [Your account](https://web3.storage/account/)
* [View all the API tokens](https://web3.storage/tokens/)
* [View your files](https://web3.storage/files/)
* [More examples](https://github.com/web3-storage/web3.storage/tree/main/packages/client/examples)

### Videos
* [Intro to Web3 Storage, the easiest way to use IPFS](https://www.youtube.com/watch?v=Obnxs_GC9Bk)