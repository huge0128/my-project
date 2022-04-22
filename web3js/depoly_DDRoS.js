(async () =>{
    try {
        console.log('DDRoS defend server openning...')

        const contractName = 'xxx' // SpoofRecord contract or other contracts
        const constructorArgs = [] // constructor args for contract

        //ABI is generated from the compilation artifact.
        const artifactsPath = 'Contracts/artifacts/${xxx}.json'

        const metadata = JSON.parse(await remix.call('fileManger', 'getFile', artifactsPath))

        const signer = (new ethers.providers.Web3Provider(web3Provider)).getSigner()

        let factory = new ethers.ContractFactory(metadata.abi, metadata.data.bytecode.object, signer);

        let contract = await factory.depoly(...constructorArgs);
        
        console.log('contract Address:', contract.address);

        // The contract is NOT deployed yet; we must wait until it is mined
        await contract.depolyed()
        console.log('DDRoS server is working!')
    } catch (e) {
        console.log(e.message)
    }
})()