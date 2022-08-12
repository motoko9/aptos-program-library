# Token

## Prerequisites

[Install Aptos CLI](https://aptos.dev/cli-tools/aptos-cli-tool/install-aptos-cli)

[Create an account and fund](https://aptos.dev/cli-tools/aptos-cli-tool/use-aptos-cli)

## Build Module

```
aptos move compile --package-dir . --named-addresses NamedAddr=0x697c173eeb917c95a382b60f546eb73a4c6a2a7b2d79e6c56c87104f9c04345f
```

```
{
  "Result": [
    "697C173EEB917C95A382B60F546EB73A4C6A2A7B2D79E6C56C87104F9C04345F::usdt"
  ]
}
```