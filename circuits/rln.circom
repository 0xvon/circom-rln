pragma circom 2.1.0;

include "./utils.circom";
include "../node_modules/circomlib/circuits/poseidon.circom";

template RLN(DEPTH, LIMIT_BIT_SIZE) {
    // Private signals
    signal input identitySecret;
    signal input userMessageLimit;
    signal input messageId;
    signal input pathElements[DEPTH];
    signal input identityPathIndex[DEPTH];

    // Public signals
    signal input x;
    signal input externalNullifier;

    // Outputs
    signal output y;
    signal output root;
    signal output nullifier;

    // TODO 1. assign identityCommitmnet to poseidon hash of [identitySecret]

    // TODO 2. assign rateCommitment to poseidon hash of [identityCommitment, userMessageLimit]


    // Membership check
    // TODO 3. assign root to merkleTreeProof of rateCommitment


    // messageId range check
    // TODO 4. check range messageId < userMessageLimit


    // SSS share calculations
    // TODO 5. calculate a1

    // TODO 6. assign y with identitySecret, a1, x

    // nullifier calculation
    // TODO 7. assign nullifier to poseidon hash of [a1]
    
}

component main { public [x, externalNullifier] } = RLN(20, 16);