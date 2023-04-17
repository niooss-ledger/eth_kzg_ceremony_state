#!/bin/sh
set -eux

cd "$(dirname -- "$0")"

curl --output current_state.json.tmp https://seq.ceremony.ethereum.org/info/current_state

TRANSCRIPT_LENGTH="$(jq '.transcripts | length' < current_state.json.tmp)"
for TRANSCRIPT_ID in $(seq 0 $((TRANSCRIPT_LENGTH - 1)) ) ; do
    jq ".transcripts[${TRANSCRIPT_ID}]" < current_state.json.tmp > "current_state_transcripts_${TRANSCRIPT_ID}.json"
done
jq .participantIds < current_state.json.tmp > current_state_participantIds.json
jq .participantEcdsaSignatures < current_state.json.tmp > current_state_participantEcdsaSignatures.json

rm current_state.json.tmp
