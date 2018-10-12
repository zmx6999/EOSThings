const apigen = require("eosjs-api/lib/apigen")
module.exports = config => {
    return apigen("v1",{
        "wallet":{
            "sign_transaction":{
                "params":"array",
                "results":"signed_transaction"
            }
        }
    },config)
}
