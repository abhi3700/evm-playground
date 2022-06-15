# Polygon PoS Bridge

## About Polygon

It is based on 2 main concepts:

- **secured chains** - "L2" i.e. plasma, optimistic-rollup, zk-rollup. It gives security. A set of validators checks the proof submitted instead of a fee charged.
- **stand-alone** chains also called "sidechains" (based on individual consensus mechanism) like Matic PoS, xDAI. It has flexibility of selecting their own consensus mechanism like PoS, DPoS, etc. It gives scalability. This is similar to parachains in Polkadot.

**Polygon architecture**:

```mermaid
sequenceDiagram
    participant Ethereum Layer
    Note over Ethereum Layer: finality, staking, dispute, messaging
    participant Security Layer
    Note over Security Layer: validator management,
```

---

## Diagram

```mermaid
sequenceDiagram
    participant Ethereum
    participant Polygon
    Ethereum ->> Polygon: Send MATIC, gas fee: ETH (from src chain)
    Polygon ->> Ethereum: Send MATIC, gas fee: MATIC (from src chain)
    loop Plasma checkpoint nodes
        Ethereum -> Polygon: tracking the transaction send by the respective contracts
    Note over Ethereum: SC A
    Note over Polygon: SC B
    end
```

## References

- Architecture overview: https://docs.matic.today/docs/contribute/matic-architecture/

## Glossary

- SC: Smart Contract
- src: source
