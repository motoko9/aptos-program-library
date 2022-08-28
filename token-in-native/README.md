# Token in native

## Prerequisites

[Install Aptos CLI](https://aptos.dev/cli-tools/aptos-cli-tool/install-aptos-cli)

[Create an account and fund](https://aptos.dev/cli-tools/aptos-cli-tool/use-aptos-cli)

## Build Module

```
aptos move compile --package-dir . --named-addresses NamedAddr=0x1685cdc9a83c3da34c59208f34bddb3217f63bfbe0c393f04462d1ba06465d08
```

```
{
  "Result": [
    "1685cdc9a83c3da34c59208f34bddb3217f63bfbe0c393f04462d1ba06465d08::usdt"
  ]
}
```

## Publish Module

```
aptos move publish --package-dir . --named-addresses NamedAddr=0x1685cdc9a83c3da34c59208f34bddb3217f63bfbe0c393f04462d1ba06465d08
```

```
package size 494 bytes
{
  "Result": {
    "transaction_hash": "0x46bfa491acd2deaaf0a46554e04e57e979ca6c7d4cfda74c2efa8f2409dc686a",
    "gas_used": 62,
    "gas_unit_price": 1,
    "sender": "1685cdc9a83c3da34c59208f34bddb3217f63bfbe0c393f04462d1ba06465d08",
    "sequence_number": 0,
    "success": true,
    "timestamp_us": 1661656715311642,
    "version": 11307262,
    "vm_status": "Executed successfully"
  }
}
```

check publish successful.

```
aptos account list --query modules --account 0x1685cdc9a83c3da34c59208f34bddb3217f63bfbe0c393f04462d1ba06465d08
```

we can see account modules.

```
{
  "Result": [
    {
      "bytecode": "0xa11ceb0b0500000005010002020204070616081c200a3c05000000010000047573647404555344540b64756d6d795f6669656c641685cdc9a83c3da34c59208f34bddb3217f63bfbe0c393f04462d1ba06465d08000201020100",
      "abi": {
        "address": "0x1685cdc9a83c3da34c59208f34bddb3217f63bfbe0c393f04462d1ba06465d08",
        "name": "usdt",
        "friends": [],
        "exposed_functions": [],
        "structs": [
          {
            "name": "USDT",
            "is_native": false,
            "abilities": [],
            "generic_type_params": [],
            "fields": [
              {
                "name": "dummy_field",
                "type": "bool"
              }
            ]
          }
        ]
      }
    }
  ]
}
```

## initilize

```
```

## register recipient


## mint


## transfer

