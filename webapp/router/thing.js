const router = require("express").Router()
const thingService = require("../service/thing")
router.post("/add",(req,res,next) => {
    thingService.add(req.body,data => {
        res.success(data)
    },msg => {
        res.fail(msg)
    })
})
router.post("/remove",(req,res,next) => {
    thingService.remove(req.body,data => {
        res.success(data)
    },msg => {
        res.fail(msg)
    })
})
router.post("/toggle",(req,res,next) => {
    thingService.toggle(req.body,data => {
        res.success(data)
    },msg => {
        res.fail(msg)
    })
})
module.exports = router
