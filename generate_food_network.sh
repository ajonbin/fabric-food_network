#!/bin/bash
set -x
rm -rf crypto-config
bin/cryptogen generate --config=./crypto-config.yaml
mkdir -p channel-artifacts
rm -rf channel-artifacts/*
bin/configtxgen -profile FoodWithEtcdRaft -channelID food-sys-channel -outputBlock ./channel-artifacts/genesis.block
bin/configtxgen -profile TransportChannel -outputCreateChannelTx ./channel-artifacts/channel.tx -channelID transport-channel
bin/configtxgen -profile TransportChannel -outputAnchorPeersUpdate ./channel-artifacts/FarmerMSPanchors.tx -channelID transport-channel -asOrg FarmerMSP
bin/configtxgen -profile TransportChannel -outputAnchorPeersUpdate ./channel-artifacts/TransportMSPanchors.tx -channelID transport-channel -asOrg TransportMSP
bin/configtxgen -profile TransportChannel -outputAnchorPeersUpdate ./channel-artifacts/SupermarketMSPanchors.tx -channelID transport-channel -asOrg SupermarketMSP


