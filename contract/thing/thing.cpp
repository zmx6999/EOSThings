#include <eosiolib/eosio.hpp>
class thing:eosio::contract {
    private:
    //@abi table things
    struct things {
        uint64_t id;
        std::string desc;
        bool done;

        uint64_t primary_key() const { return id; }
    };
    typedef eosio::multi_index<N(things),things> thing_table;

    public:
    thing(account_name self):eosio::contract(self) {}
    //@abi action
    void add(account_name author,const uint64_t id,const std::string& desc) {
        require_auth(author);
        thing_table t(_self,author);
        t.emplace(author,[&](auto& record) {
            record.id=id;
            record.desc=desc;
            record.done=false;
        });
    }
    //@abi action
    void remove(account_name author,const uint64_t id) {
        require_auth(author);
        thing_table t(_self,author);
        auto item=t.find(id);
        eosio_assert(item!=t.end(),"record not found");
        t.erase(item);
    }
    //@abi action
    void toggle(account_name author,const uint64_t id) {
        require_auth(author);
        thing_table t(_self,author);
        auto item=t.find(id);
        eosio_assert(item!=t.end(),"record not found");
        t.modify(item,author,[&](auto& record) {
            record.done=!record.done;
        });
    }
};
EOSIO_ABI(thing,(add)(remove)(toggle))