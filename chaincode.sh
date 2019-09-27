#!/bin/bash


export CHAINCODE_VERSION=1
export CHAINCODE_NAME=abstore
export CHAINCODE_SEQUENCE=1

export CORE_PEER_ADDRESS=apple.farmer.com:7051
export CORE_PEER_LOCALMSPID=FarmerMSP
export CORE_PEER_TLS_CERT_FILE=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/farmer.com/peers/apple.farmer.com/tls/server.crt
export CORE_PEER_TLS_KEY_FILE=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/farmer.com/peers/apple.farmer.com/tls/server.key
export CORE_PEER_TLS_ROOTCERT_FILE=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/farmer.com/peers/apple.farmer.com/tls/ca.crt
export CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/farmer.com/users/Admin@farmer.com/msp

peer lifecycle chaincode package ${CHAINCODE_NAME}.tar.gz --path github.com/hyperledger/fabric/chaincode/${CHAINCODE_NAME}/go --lang golang --label ${CHAINCODE_NAME}_${CHAINCODE_VERSION}

export CORE_PEER_ADDRESS=apple.farmer.com:7051
peer lifecycle chaincode install ${CHAINCODE_NAME}.tar.gz
peer lifecycle chaincode queryinstalled

export CORE_PEER_ADDRESS=pear.farmer.com:8051
peer lifecycle chaincode install ${CHAINCODE_NAME}.tar.gz
peer lifecycle chaincode queryinstalled

export CORE_PEER_ADDRESS=melon.farmer.com:9051
peer lifecycle chaincode install ${CHAINCODE_NAME}.tar.gz
peer lifecycle chaincode queryinstalled

export PACKAGE_ID="${CHAINCODE_NAME}_${CHAINCODE_VERSION}:34e1d967ab04f9d30d12aad055e3596f7bb6e929839b3914852cf337b56c226c"
export PACKAGE_ID="${CHAINCODE_NAME}_${CHAINCODE_VERSION}:4272de1262b4e807105bdd475a5aa20dfd5346eba6b2c90c33982dc3d127a767"
#peer lifecycle chaincode approveformyorg --tls true --cafile /opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/ordererOrganizations/farmer.com/orderers/orderer.farmer.com/msp/tlscacerts/tlsca.farmer.com-cert.pem --channelID transport-channel --name ${CHAINCODE_NAME} --version ${CHAINCODE_VERSION} --init-required  --sequence ${CHAINCODE_VERSION} --waitForEvent --package-id ${PACKAGE_ID} --orderer orderer.farmer.com:7050
peer lifecycle chaincode approveformyorg --tls true --cafile /opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/ordererOrganizations/farmer.com/orderers/orderer.farmer.com/msp/tlscacerts/tlsca.farmer.com-cert.pem --channelID transport-channel --name ${CHAINCODE_NAME} --version ${CHAINCODE_VERSION} --init-required --sequence ${CHAINCODE_SEQUENCE} --waitForEvent --package-id ${PACKAGE_ID} --orderer orderer.farmer.com:7050
peer lifecycle chaincode queryapprovalstatus --tls true --cafile /opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/ordererOrganizations/farmer.com/orderers/orderer.farmer.com/msp/tlscacerts/tlsca.farmer.com-cert.pem --channelID transport-channel --name ${CHAINCODE_NAME} --version ${CHAINCODE_VERSION} --init-required --sequence ${CHAINCODE_SEQUENCE} --orderer orderer.farmer.com:7050

export CORE_PEER_ADDRESS=cargo.truck.transport.com:14051
export CORE_PEER_LOCALMSPID=TransportMSP
export CORE_PEER_TLS_CERT_FILE=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/transport.com/peers/cargo.truck.transport.com/tls/server.crt
export CORE_PEER_TLS_KEY_FILE=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/transport.com/peers/cargo.truck.transport.com/tls/server.key
export CORE_PEER_TLS_ROOTCERT_FILE=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/transport.com/peers/cargo.truck.transport.com/tls/ca.crt
export CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/transport.com/users/Admin@transport.com/msp

export CORE_PEER_ADDRESS=cargo.truck.transport.com:14051
peer lifecycle chaincode install ${CHAINCODE_NAME}.tar.gz

export CORE_PEER_ADDRESS=refrigerated.truck.transport.com:15051
peer lifecycle chaincode install ${CHAINCODE_NAME}.tar.gz

peer lifecycle chaincode approveformyorg --tls true --cafile /opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/ordererOrganizations/transport.com/orderers/orderer.transport.com/msp/tlscacerts/tlsca.transport.com-cert.pem --channelID transport-channel --name ${CHAINCODE_NAME} --version ${CHAINCODE_VERSION} --init-required --sequence ${CHAINCODE_SEQUENCE} --waitForEvent --package-id ${PACKAGE_ID} --orderer orderer.transport.com:7050
peer lifecycle chaincode queryapprovalstatus --tls true --cafile /opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/ordererOrganizations/transport.com/orderers/orderer.transport.com/msp/tlscacerts/tlsca.transport.com-cert.pem --channelID transport-channel --name ${CHAINCODE_NAME} --version ${CHAINCODE_VERSION} --init-required --sequence ${CHAINCODE_SEQUENCE} --orderer orderer.transport.com:7050


export CORE_PEER_ADDRESS=peer0.supermarket.com:12051
export CORE_PEER_LOCALMSPID=SupermarketMSP
export CORE_PEER_TLS_CERT_FILE=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/supermarket.com/peers/peer0.supermarket.com/tls/server.crt
export CORE_PEER_TLS_KEY_FILE=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/supermarket.com/peers/peer0.supermarket.com/tls/server.key
export CORE_PEER_TLS_ROOTCERT_FILE=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/supermarket.com/peers/peer0.supermarket.com/tls/ca.crt
export CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/supermarket.com/users/Admin@supermarket.com/msp

export CORE_PEER_ADDRESS=peer0.supermarket.com:12051
peer lifecycle chaincode install ${CHAINCODE_NAME}.tar.gz

export CORE_PEER_ADDRESS=peer1.supermarket.com:13051
peer lifecycle chaincode install ${CHAINCODE_NAME}.tar.gz
peer lifecycle chaincode queryinstalled

peer lifecycle chaincode approveformyorg --tls true --cafile /opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/ordererOrganizations/supermarket.com/orderers/orderer.supermarket.com/msp/tlscacerts/tlsca.supermarket.com-cert.pem --channelID transport-channel --name ${CHAINCODE_NAME} --version ${CHAINCODE_VERSION} --init-required --sequence ${CHAINCODE_SEQUENCE} --waitForEvent --package-id ${PACKAGE_ID} --orderer orderer.supermarket.com:7050
peer lifecycle chaincode queryapprovalstatus --tls true --cafile /opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/ordererOrganizations/supermarket.com/orderers/orderer.supermarket.com/msp/tlscacerts/tlsca.supermarket.com-cert.pem --channelID transport-channel --name ${CHAINCODE_NAME} --version ${CHAINCODE_VERSION} --init-required --sequence ${CHAINCODE_SEQUENCE} --orderer orderer.supermarket.com:7050


export PEERS_ADDRESSES='--peerAddresses apple.farmer.com:7051 --tlsRootCertFiles /opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/farmer.com/peers/apple.farmer.com/tls/ca.crt --peerAddresses cargo.truck.transport.com:14051 --tlsRootCertFiles /opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/transport.com/peers/cargo.truck.transport.com/tls/ca.crt  --peerAddresses peer0.supermarket.com:12051 --tlsRootCertFiles /opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/supermarket.com/peers/peer0.supermarket.com/tls/ca.crt'
#peer lifecycle chaincode commit -o orderer.supermarket.com:7050 --tls --cafile /opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/ordererOrganizations/supermarket.com/orderers/orderer.supermarket.com/msp/tlscacerts/tlsca.supermarket.com-cert.pem --channelID transport-channel --peerAddresses apple.farmer.com:7051 --tlsRootCertFiles /opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/farmer.com/peers/apple.farmer.com/tls/ca.crt --peerAddresses cargo.truck.transport.com:14051 --tlsRootCertFiles /opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/transport.com/peers/cargo.truck.transport.com/tls/ca.crt  --peerAddresses peer0.supermarket.com:12051 --tlsRootCertFiles /opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/supermarket.com/peers/peer0.supermarket.com/tls/ca.crt --name ${CHAINCODE_NAME} --version ${CHAINCODE_VERSION} --sequence ${CHAINCODE_VERSION} --init-required 

peer lifecycle chaincode querycommitted -o orderer.supermarket.com:7050 --tls --cafile /opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/ordererOrganizations/supermarket.com/orderers/orderer.supermarket.com/msp/tlscacerts/tlsca.supermarket.com-cert.pem --channelID transport-channel --name ${CHAINCODE_NAME} 

peer lifecycle chaincode commit -o orderer.supermarket.com:7050 --tls --cafile /opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/ordererOrganizations/supermarket.com/orderers/orderer.supermarket.com/msp/tlscacerts/tlsca.supermarket.com-cert.pem --channelID transport-channel  ${PEERS_ADDRESSES} --name ${CHAINCODE_NAME} --init-required --version ${CHAINCODE_VERSION} --sequence ${CHAINCODE_SEQUENCE} 

peer lifecycle chaincode querycommitted -o orderer.supermarket.com:7050 --tls --cafile /opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/ordererOrganizations/supermarket.com/orderers/orderer.supermarket.com/msp/tlscacerts/tlsca.supermarket.com-cert.pem --channelID transport-channel --name ${CHAINCODE_NAME} 


export ORDERER_CA='/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/ordererOrganizations/supermarket.com/orderers/orderer.supermarket.com/msp/tlscacerts/tlsca.supermarket.com-cert.pem'
export CHANNEL_NAME='transport-channel'

if [[ $CHAINCODE_NAME -eq 'abstore']]; then
    peer chaincode invoke -o orderer.supermarket.com:7050 --tls true  --cafile ${ORDERER_CA} --channelID $CHANNEL_NAME --name ${CHAINCODE_NAME} ${PEERS_ADDRESSES} --isInit --ctor '{"Args":["Init","a","100","b","100"]}' 
    peer chaincode invoke -o orderer.supermarket.com:7050 --tls true  --cafile ${ORDERER_CA} --channelID $CHANNEL_NAME --name ${CHAINCODE_NAME} ${PEERS_ADDRESSES} -c '{"Args":["query","a"]}'
    peer chaincode query -o orderer.supermarket.com:7050 --tls true  --cafile ${ORDERER_CA} --channelID $CHANNEL_NAME --name ${CHAINCODE_NAME}  -c '{"Args":["query","a"]}'
else
    peer chaincode invoke -o orderer.supermarket.com:7050 --tls true  --cafile ${ORDERER_CA} --channelID $CHANNEL_NAME --name ${CHAINCODE_NAME} ${PEERS_ADDRESSES} --isInit --ctor '{"Args":[]}' 
    peer chaincode invoke -o orderer.supermarket.com:7050 --tls true  --cafile ${ORDERER_CA} --channelID $CHANNEL_NAME --name ${CHAINCODE_NAME} ${PEERS_ADDRESSES} -c '{"Args":["queryAllCars"]}' 
    peer chaincode invoke -o orderer.supermarket.com:7050 --tls true  --cafile ${ORDERER_CA} --channelID $CHANNEL_NAME --name ${CHAINCODE_NAME} ${PEERS_ADDRESSES} -c '{"Args":["initLedger"]}'
    peer chaincode query -o orderer.supermarket.com:7050 --tls true  --cafile ${ORDERER_CA} --channelID $CHANNEL_NAME --name ${CHAINCODE_NAME}  -c '{"Args":["queryAllCars"]}' 
fi

