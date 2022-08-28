# Token

## Prerequisites

[Install Aptos CLI](https://aptos.dev/cli-tools/aptos-cli-tool/install-aptos-cli)

[Create an account and fund](https://aptos.dev/cli-tools/aptos-cli-tool/use-aptos-cli)

## Build Module

```
aptos move compile --package-dir . --named-addresses NamedAddr=0x5e7f8779c8c26ec3cbba37337142b2aaa2291b4779f4b386a0de83da177df510
```

```
{
  "Result": [
    "5e7f8779c8c26ec3cbba37337142b2aaa2291b4779f4b386a0de83da177df510::helloworld"
  ]
}
```

## Publish Module

```
aptos move publish --package-dir . --named-addresses NamedAddr=0x5e7f8779c8c26ec3cbba37337142b2aaa2291b4779f4b386a0de83da177df510
```

```
package size 1660 bytes
{
  "Result": {
    "transaction_hash": "0xec24b2c091d0c02a55a2caa223e9883fa10bfb62a920967b0b694dcebe14e61b",
    "gas_used": 189,
    "gas_unit_price": 1,
    "sender": "5e7f8779c8c26ec3cbba37337142b2aaa2291b4779f4b386a0de83da177df510",
    "sequence_number": 0,
    "success": true,
    "timestamp_us": 1661650597217213,
    "version": 10901294,
    "vm_status": "Executed successfully"
  }
}
```

check publish successful.

```
aptos account list --query modules --account 0x5e7f8779c8c26ec3cbba37337142b2aaa2291b4779f4b386a0de83da177df510
```

we can see account modules.

```
{
  "Result": [
    {
      "bytecode": "0xa11ceb0b050000000c01000c020c12031e20043e04054228076ae00108ca0240068a030a109403450ad903150cee035f0dcd0404000001010102010301040105000606000007080005080700030f040106010009000100000a02030002100404000411060000011206080106031309030106040705070105010802020c08020001030305080207080101060c010800010b0301090002070b0301090009000a68656c6c6f776f726c64076163636f756e74056572726f72056576656e74067369676e657206737472696e67124d6573736167654368616e67654576656e740d4d657373616765486f6c64657206537472696e670b6765745f6d6573736167650b7365745f6d6573736167650c66726f6d5f6d6573736167650a746f5f6d657373616765076d657373616765156d6573736167655f6368616e67655f6576656e74730b4576656e7448616e646c65096e6f745f666f756e640a616464726573735f6f66106e65775f6576656e745f68616e646c650a656d69745f6576656e745e7f8779c8c26ec3cbba37337142b2aaa2291b4779f4b386a0de83da177df510000000000000000000000000000000000000000000000000000000000000000103080000000000000000126170746f733a3a6d657461646174615f7630310100000000000000000b454e4f5f4d4553534147451b5468657265206973206e6f206d6573736167652070726573656e740002020b08020c08020102020d08020e0b030108000001000101030b0a002901030607001102270b002b0110001402010104010105210e0011030c020a022901200308050f0e000b010e00380012012d0105200b022a010c040a041000140c030a040f010b030a01120038010b010b040f0015020100010100",
      "abi": {
        "address": "0x5e7f8779c8c26ec3cbba37337142b2aaa2291b4779f4b386a0de83da177df510",
        "name": "helloworld",
        "friends": [],
        "exposed_functions": [
          {
            "name": "get_message",
            "visibility": "public",
            "is_entry": false,
            "generic_type_params": [],
            "params": [
              "address"
            ],
            "return": [
              "0x1::string::String"
            ]
          },
          {
            "name": "set_message",
            "visibility": "public",
            "is_entry": true,
            "generic_type_params": [],
            "params": [
              "signer",
              "0x1::string::String"
            ],
            "return": []
          }
        ],
        "structs": [
          {
            "name": "MessageChangeEvent",
            "is_native": false,
            "abilities": [
              "drop",
              "store"
            ],
            "generic_type_params": [],
            "fields": [
              {
                "name": "from_message",
                "type": "0x1::string::String"
              },
              {
                "name": "to_message",
                "type": "0x1::string::String"
              }
            ]
          },
          {
            "name": "MessageHolder",
            "is_native": false,
            "abilities": [
              "key"
            ],
            "generic_type_params": [],
            "fields": [
              {
                "name": "message",
                "type": "0x1::string::String"
              },
              {
                "name": "message_change_events",
                "type": "0x1::event::EventHandle<0x5e7f8779c8c26ec3cbba37337142b2aaa2291b4779f4b386a0de83da177df510::helloworld::MessageChangeEvent>"
              }
            ]
          }
        ]
      }
    }
  ]
}

```

## set message

```

```

## read message


