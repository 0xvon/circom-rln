pragma circom 2.1.0;

include "./utils.circom";
include "../node_modules/circomlib/circuits/comparators.circom";
include "../node_modules/circomlib/circuits/bitify.circom";
include "../node_modules/circomlib/circuits/poseidon.circom";

template RLN(DEPTH, LIMIT_BIT_SIZE) {
    // Private signals
    signal input identitySecret;
    signal input messageId;
    signal input pathElements[DEPTH];
    signal input identityPathIndex[DEPTH];

    // Public signals
    signal input x;
    signal input externalNullifier;
    signal input messageLimit;

    // Outputs
    signal output y;
    signal output root;
    signal output nullifier;

    signal identityCommitment <== Poseidon(1)([identitySecret]);

    root <== MerkleTreeInclusionProof(DEPTH)(identityCommitment, identityPathIndex, pathElements);

    // Check that messageId's big size is indeed of LIMIT_BIT_SIZE
    signal bitCheck[LIMIT_BIT_SIZE] <== Num2Bits(LIMIT_BIT_SIZE)(messageId);
    
    // Range check that messageId belongs in [0, messageLimit)
    signal rangeCheck <== LessThan(LIMIT_BIT_SIZE)([messageId, messageLimit]);
    rangeCheck === 1;

    signal a1 <== Poseidon(3)([identitySecret, externalNullifier, messageId]);
    y <== identitySecret + a1 * x;

    nullifier <== Poseidon(1)([a1]);
}

component main { public [x, externalNullifier, messageLimit] } = RLN(20, 16);