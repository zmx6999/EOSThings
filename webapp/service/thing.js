const WalletApi = require("../WalletApi")
const keosd = WalletApi({
    httpEndpoint:"http://127.0.0.1:8900"
})
const fs = require("fs")
const getkey = user => {
    return fs.readFileSync("/root/artifacts/"+user+"/public.pem","utf-8").trim()
}
const eos = require("eosjs")
const nodeos = user => {
    return eos({
        httpEndpoint:"http://127.0.0.1:8888",
        signProvider:({transaction}) => {
            return keosd.signTransaction([
                transaction,
                [getkey(user)],
                "cf057bbfb72640471fd910bcb67639c22df9f92470936cddc1ade0e2f2e7dc4f"
            ]).then(r => r.signatures[0])
        }
    })
}
const add = (options,success,error) => {
    const _nodeos = nodeos(options.user)
    _nodeos.contract(options.contract)
        .then(contract => contract.add(options.user,Date.now(),options.desc,{authorization:options.user}))
        .then(() => _nodeos.getTableRows(true,options.contract,options.user,"things"))
        .then(rsp => success && success(rsp))
        .catch(err => error && error(JSON.parse(err)))
}
const remove = (options,success,error) => {
    const _nodeos = nodeos(options.user)
    _nodeos.contract(options.contract)
        .then(contract => contract.remove(options.user,options.id,{authorization:options.user}))
        .then(() => _nodeos.getTableRows(true,options.contract,options.user,"things"))
        .then(rsp => success && success(rsp))
        .catch(err => error && error(JSON.parse(err)))
}
const toggle = (options,success,error) => {
    const _nodeos = nodeos(options.user)
    _nodeos.contract(options.contract)
        .then(contract => contract.toggle(options.user,options.id,{authorization:options.user}))
        .then(() => _nodeos.getTableRows(true,options.contract,options.user,"things"))
        .then(rsp => success && success(rsp))
        .catch(err => error && error(JSON.parse(err)))
}
module.exports = {
    add,remove,toggle
}
