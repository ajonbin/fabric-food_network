# Build Multi-Org Networks #

## Quick Start ##

~~~
bin/cryptogen generate --config=./crypto-config.yaml
bin/configtxgen -profile TransportChannel -outputCreateChannelTx ./channel-artifacts/channel.tx -channelID transport-channel
bin/configtxgen -profile TransportChannel -outputAnchorPeersUpdate ./channel-artifacts/FarmerMSPanchors.tx -channelID transport-channel -asOrg FarmerMSP
bin/configtxgen -profile TransportChannel -outputAnchorPeersUpdate ./channel-artifacts/TransportMSPanchors.tx -channelID transport-channel -asOrg TransportMSP
bin/configtxgen -profile TransportChannel -outputAnchorPeersUpdate ./channel-artifacts/SupermarketMSPanchors.tx -channelID transport-channel -asOrg SupermarketMSP
~~~

docker exec -ti fabric-cli bash
~~~

~~~

## Walk Through ##

* Generate Certifications 
* Generate Channel Artifacts
    * Orderer Genesis block
    * Channel Configuration Transaction
* Bring up Fabric Network
    * Images:
        * hyperledger/fabric-tools
        * hyperledger/fabric-peer
        * hyperledger/fabric-orderer
        * hyperledger/fabric-ca
        * couchdb:2.3



## Setup ##

### Food Organizations ###
* Farmer
    * orderer.farmer.com
    * Peers:
        * apple.farmer.com
        * pear.farmer.com
        * melon.farmer.com
* Transport
    * orderer.transport.com
    * Peers:
        * cargo.truck.transport.com
        * refrigerated.truck.transport.com
* Supermarket
    * orderer.supermarket.com
    * Peers:
        * peer0.supermarket.com
        * peer1.supermarket.com
* Government
    * orderer.government.com
    * Peers:
        * peer0.government.com
        * peer1.government.com

### Globals for CLI ###

#### farmer.com ####

**apple.farmer.com**

~~~
export CORE_PEER_ADDRESS=apple.farmer.com:7051
export CORE_PEER_LOCALMSPID=FarmerMSP
export CORE_PEER_TLS_CERT_FILE=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/farmer.com/peers/apple.farmer.com/tls/server.crt
export CORE_PEER_TLS_KEY_FILE=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/farmer.com/peers/apple.farmer.com/tls/server.key
export CORE_PEER_TLS_ROOTCERT_FILE=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/farmer.com/peers/apple.farmer.com/tls/ca.crt
export CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/farmer.com/users/Admin@farmer.com/msp
~~~

**pear.farmer.com**
~~~
export CORE_PEER_ADDRESS=pear.farmer.com:8051
export CORE_PEER_LOCALMSPID=FarmerMSP
export CORE_PEER_TLS_CERT_FILE=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/farmer.com/peers/pear.farmer.com/tls/server.crt
export CORE_PEER_TLS_KEY_FILE=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/farmer.com/peers/pear.farmer.com/tls/server.key
export CORE_PEER_TLS_ROOTCERT_FILE=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/farmer.com/peers/pear.farmer.com/tls/ca.crt
export CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/farmer.com/users/Admin@farmer.com/msp
~~~

**melon.farmer.com**
~~~
export CORE_PEER_ADDRESS=melon.farmer.com:9051
export CORE_PEER_LOCALMSPID=FarmerMSP
export CORE_PEER_TLS_CERT_FILE=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/farmer.com/peers/melon.farmer.com/tls/server.crt
export CORE_PEER_TLS_KEY_FILE=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/farmer.com/peers/melon.farmer.com/tls/server.key
export CORE_PEER_TLS_ROOTCERT_FILE=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/farmer.com/peers/melon.farmer.com/tls/ca.crt
export CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/farmer.com/users/Admin@farmer.com/msp
~~~

#### transport.com ####

**cargo.truck.transport.com**
~~~
export CORE_PEER_ADDRESS=cargo.truck.transport.com:14051
export CORE_PEER_LOCALMSPID=TransportMSP
export CORE_PEER_TLS_CERT_FILE=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/transport.com/peers/cargo.truck.transport.com/tls/server.crt
export CORE_PEER_TLS_KEY_FILE=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/transport.com/peers/cargo.truck.transport.com/tls/server.key
export CORE_PEER_TLS_ROOTCERT_FILE=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/transport.com/peers/cargo.truck.transport.com/tls/ca.crt
export CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/transport.com/users/Admin@transport.com/msp
~~~

**refrigerated.truck.transport.com**
~~~
export CORE_PEER_ADDRESS=refrigerated.truck.transport.com:15051
export CORE_PEER_LOCALMSPID=TransportMSP
export CORE_PEER_TLS_CERT_FILE=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/transport.com/peers/refrigerated.truck.transport.com/tls/server.crt
export CORE_PEER_TLS_KEY_FILE=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/transport.com/peers/refrigerated.truck.transport.com/tls/server.key
export CORE_PEER_TLS_ROOTCERT_FILE=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/transport.com/peers/refrigerated.truck.transport.com/tls/ca.crt
export CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/transport.com/users/Admin@transport.com/msp
~~~

### Generate Certificates ###


~~~
$ ../bin/cryptogen showtemplate
~~~

~~~

# ---------------------------------------------------------------------------
# "OrdererOrgs" - Definition of organizations managing orderer nodes
# ---------------------------------------------------------------------------
OrdererOrgs:
  # ---------------------------------------------------------------------------
  # Orderer
  # ---------------------------------------------------------------------------
  - Name: Orderer
    Domain: example.com

    # ---------------------------------------------------------------------------
    # "Specs" - See PeerOrgs below for complete description
    # ---------------------------------------------------------------------------
    Specs:
      - Hostname: orderer

# ---------------------------------------------------------------------------
# "PeerOrgs" - Definition of organizations managing peer nodes
# ---------------------------------------------------------------------------
PeerOrgs:
  # ---------------------------------------------------------------------------
  # Org1
  # ---------------------------------------------------------------------------
  - Name: Org1
    Domain: org1.example.com
    EnableNodeOUs: false

    # ---------------------------------------------------------------------------
    # "CA"
    # ---------------------------------------------------------------------------
    # Uncomment this section to enable the explicit definition of the CA for this
    # organization.  This entry is a Spec.  See "Specs" section below for details.
    # ---------------------------------------------------------------------------
    # CA:
    #    Hostname: ca # implicitly ca.org1.example.com
    #    Country: US
    #    Province: California
    #    Locality: San Francisco
    #    OrganizationalUnit: Hyperledger Fabric
    #    StreetAddress: address for org # default nil
    #    PostalCode: postalCode for org # default nil

    # ---------------------------------------------------------------------------
    # "Specs"
    # ---------------------------------------------------------------------------
    # Uncomment this section to enable the explicit definition of hosts in your
    # configuration.  Most users will want to use Template, below
    #
    # Specs is an array of Spec entries.  Each Spec entry consists of two fields:
    #   - Hostname:   (Required) The desired hostname, sans the domain.
    #   - CommonName: (Optional) Specifies the template or explicit override for
    #                 the CN.  By default, this is the template:
    #
    #                              "{{.Hostname}}.{{.Domain}}"
    #
    #                 which obtains its values from the Spec.Hostname and
    #                 Org.Domain, respectively.
    #   - SANS:       (Optional) Specifies one or more Subject Alternative Names
    #                 to be set in the resulting x509. Accepts template
    #                 variables {{.Hostname}}, {{.Domain}}, {{.CommonName}}. IP
    #                 addresses provided here will be properly recognized. Other
    #                 values will be taken as DNS names.
    #                 NOTE: Two implicit entries are created for you:
    #                     - {{ .CommonName }}
    #                     - {{ .Hostname }}
    # ---------------------------------------------------------------------------
    # Specs:
    #   - Hostname: foo # implicitly "foo.org1.example.com"
    #     CommonName: foo27.org5.example.com # overrides Hostname-based FQDN set above
    #     SANS:
    #       - "bar.{{.Domain}}"
    #       - "altfoo.{{.Domain}}"
    #       - "{{.Hostname}}.org6.net"
    #       - 172.16.10.31
    #   - Hostname: bar
    #   - Hostname: baz

    # ---------------------------------------------------------------------------
    # "Template"
    # ---------------------------------------------------------------------------
    # Allows for the definition of 1 or more hosts that are created sequentially
    # from a template. By default, this looks like "peer%d" from 0 to Count-1.
    # You may override the number of nodes (Count), the starting index (Start)
    # or the template used to construct the name (Hostname).
    #
    # Note: Template and Specs are not mutually exclusive.  You may define both
    # sections and the aggregate nodes will be created for you.  Take care with
    # name collisions
    # ---------------------------------------------------------------------------
    Template:
      Count: 1
      # Start: 5
      # Hostname: {{.Prefix}}{{.Index}} # default
      # SANS:
      #   - "{{.Hostname}}.alt.{{.Domain}}"

    # ---------------------------------------------------------------------------
    # "Users"
    # ---------------------------------------------------------------------------
    # Count: The number of user accounts _in addition_ to Admin
    # ---------------------------------------------------------------------------
    Users:
      Count: 1

  # ---------------------------------------------------------------------------
  # Org2: See "Org1" for full specification
  # ---------------------------------------------------------------------------
  - Name: Org2
    Domain: org2.example.com
    EnableNodeOUs: false
    Template:
      Count: 1
    Users:
      Count: 1

~~~

~~~
$ bin/cryptogen generate --config=./crypto-config.yaml
~~~

~~~
farmer.com
vehicle.transport.com
walmar.supermarket.com
tax.government.com
~~~
crypto-config.yaml

~~~

OrdererOrgs:
  - Name: Orderer
    Domain: farmer.com
    Specs:
      - Hostname: orderer
  - Name: Orderer
    Domain: transport.com
    Specs:
      - Hostname: orderer
  - Name: Orderer
    Domain: supermarket.com
    Specs:
      - Hostname: orderer
  - Name: Orderer
    Domain: government.com
    Specs:
      - Hostname: orderer

PeerOrgs:
  - Name: farmer
    Domain: farmer.com
    EnableNodeOUs: false
    Specs:
      - Hostname: apple
      - Hostname: pear
      - Hostname: melon
    Users:
      Count: 3
  - Name: Vehicle
    Domain: vehicle.transport.com
    EnableNodeOUs: false
    Template:
      Count: 2
    Users:
      Count: 1
  - Name: walmar
    Domain: walmar.supermarket.com
    EnableNodeOUs: false
    Template:
      Count: 2
    Users:
      Count: 1
  - Name: tax
    Domain: tax.government.com
    EnableNodeOUs: false
    Template:
      Count: 2
    Users:
      Count: 1
~~~

### Generate Channel Artifacts ###


#### Generate Orderer Genesis block ####

~~~
mkdir channel-artifacts
bin/configtxgen -profile FoodWithEtcdRaft -channelID food-sys-channel -outputBlock ./channel-artifacts/genesis.block
~~~

~~~shell
2019-08-12 14:56:20.514 CST [common.tools.configtxgen] main -> INFO 001 Loading configuration
2019-08-12 14:56:20.539 CST [common.tools.configtxgen.localconfig] completeInitialization -> INFO 002 Orderer.BatchTimeout unset, setting to 2s
2019-08-12 14:56:20.539 CST [common.tools.configtxgen.localconfig] completeInitialization -> INFO 003 Orderer.BatchSize.MaxMessageCount unset, setting to 500
2019-08-12 14:56:20.539 CST [common.tools.configtxgen.localconfig] completeInitialization -> INFO 004 Orderer.BatchSize.AbsoluteMaxBytes unset, setting to 10485760
2019-08-12 14:56:20.539 CST [common.tools.configtxgen.localconfig] completeInitialization -> INFO 005 Orderer.BatchSize.PreferredMaxBytes unset, setting to 2097152
2019-08-12 14:56:20.539 CST [common.tools.configtxgen.localconfig] completeInitialization -> INFO 006 orderer type: etcdraft
2019-08-12 14:56:20.539 CST [common.tools.configtxgen.localconfig] completeInitialization -> INFO 007 Orderer.EtcdRaft.Options unset, setting to tick_interval:"500ms" election_tick:10 heartbeat_tick:1 max_inflight_blocks:5 snapshot_interval_size:20971520 
2019-08-12 14:56:20.539 CST [common.tools.configtxgen.localconfig] Load -> INFO 008 Loaded configuration: /Users/haimhuan/farbic_2.0a/food-network/configtx.yaml
2019-08-12 14:56:20.562 CST [common.tools.configtxgen.localconfig] LoadTopLevel -> INFO 009 Loaded configuration: /Users/haimhuan/farbic_2.0a/food-network/configtx.yaml
2019-08-12 14:56:20.650 CST [common.tools.configtxgen] doOutputBlock -> INFO 00a Generating genesis block
2019-08-12 14:56:20.651 CST [common.tools.configtxgen] doOutputBlock -> INFO 00b Writing genesis block
~~~

#### Create Channel ####
##### Generating channel configuration transaction #####
```
graph LR
A-->B
```

```
graph LR
A-->B
```


A channel is created using a **channel config update transaction**. Specifically, it’s a transaction to create a configuration for the new channel.


~~~ shell 
bin/configtxgen -profile TransportChannel -outputCreateChannelTx ./channel-artifacts/channel.tx -channelID transport-channel
~~~

~~~ shell
2019-08-12 15:45:41.018 CST [common.tools.configtxgen] main -> INFO 001 Loading configuration
2019-08-12 15:45:41.057 CST [common.tools.configtxgen.localconfig] Load -> INFO 002 Loaded configuration: /Users/haimhuan/farbic_2.0a/food-network/configtx.yaml
2019-08-12 15:45:41.095 CST [common.tools.configtxgen.localconfig] LoadTopLevel -> INFO 003 Loaded configuration: /Users/haimhuan/farbic_2.0a/food-network/configtx.yaml
2019-08-12 15:45:41.095 CST [common.tools.configtxgen] doOutputChannelCreateTx -> INFO 004 Generating new channel configtx
2019-08-12 15:45:41.126 CST [common.tools.configtxgen] doOutputChannelCreateTx -> INFO 005 Writing new channel tx
~~~

#### Add Orgnizations to Channel ####
##### Generating anchor peer update #####

~~~
bin/configtxgen -profile TransportChannel -outputAnchorPeersUpdate ./channel-artifacts/FarmerMSPanchors.tx -channelID transport-channel -asOrg FarmerMSP

bin/configtxgen -profile TransportChannel -outputAnchorPeersUpdate ./channel-artifacts/TransportMSPanchors.tx -channelID transport-channel -asOrg TransportMSP

bin/configtxgen -profile TransportChannel -outputAnchorPeersUpdate ./channel-artifacts/SupermarketMSPanchors.tx -channelID transport-channel -asOrg SupermarketMSP
~~~


~~~
2019-08-12 16:16:32.810 CST [common.tools.configtxgen] main -> INFO 001 Loading configuration
2019-08-12 16:16:32.848 CST [common.tools.configtxgen.localconfig] Load -> INFO 002 Loaded configuration: /Users/haimhuan/farbic_2.0a/food-network/configtx.yaml
2019-08-12 16:16:32.889 CST [common.tools.configtxgen.localconfig] LoadTopLevel -> INFO 003 Loaded configuration: /Users/haimhuan/farbic_2.0a/food-network/configtx.yaml
2019-08-12 16:16:32.889 CST [common.tools.configtxgen] doOutputAnchorPeersUpdate -> INFO 004 Generating anchor peer update
2019-08-12 16:16:32.906 CST [common.tools.configtxgen] doOutputAnchorPeersUpdate -> INFO 005 Writing anchor peer update
~~~

## Bring up services ##

~~~ shell
docker-compose -f docker-compose-farmer.yaml -f docker-compose-government.yaml -f docker-compose-transport.yaml -f docker-compose-supermarket.yaml up
~~~

## Channel ##

### Create Channel and Join Channel ###
~~~
$ docker exec -ti transport-cli bash

bash-4.4# peer channel create -o orderer.transport.com:7050 -c transport-channel -f /opt/gopath/src/github.com/hyperledger/fabric/peer/channel-artifacts/channel.tx --tls --cafile /opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/ordererOrganizations/transport.com/msp/tlscacerts/tlsca.transport.com-cert.pem
2019-08-26 16:04:44.824 UTC [channelCmd] InitCmdFactory -> INFO 001 Endorser and orderer connections initialized
2019-08-26 16:04:44.908 UTC [cli.common] readBlock -> INFO 002 Got status: &{NOT_FOUND}
2019-08-26 16:04:44.931 UTC [channelCmd] InitCmdFactory -> INFO 003 Endorser and orderer connections initialized
2019-08-26 16:04:45.134 UTC [cli.common] readBlock -> INFO 004 Got status: &{SERVICE_UNAVAILABLE}
2019-08-26 16:04:45.149 UTC [channelCmd] InitCmdFactory -> INFO 005 Endorser and orderer connections initialized
2019-08-26 16:04:45.351 UTC [cli.common] readBlock -> INFO 006 Got status: &{SERVICE_UNAVAILABLE}
2019-08-26 16:04:45.364 UTC [channelCmd] InitCmdFactory -> INFO 007 Endorser and orderer connections initialized
2019-08-26 16:04:45.581 UTC [cli.common] readBlock -> INFO 008 Received block: 0

bash-4.4# peer channel list
2019-08-26 16:05:06.098 UTC [channelCmd] InitCmdFactory -> INFO 001 Endorser and orderer connections initialized
Channels peers has joined: 

bash-4.4# peer channel join -b /opt/gopath/src/github.com/hyperledger/fabric/peer/transport-channel.block 
2019-08-26 16:06:46.142 UTC [channelCmd] InitCmdFactory -> INFO 001 Endorser and orderer connections initialized
2019-08-26 16:06:46.249 UTC [channelCmd] executeJoin -> INFO 002 Successfully submitted proposal to join channel

bash-4.4# peer channel list
2019-08-26 16:06:54.170 UTC [channelCmd] InitCmdFactory -> INFO 001 Endorser and orderer connections initialized
Channels peers has joined: 
transport-channel

bash-4.4# export CORE_PEER_ADDRESS=refrigerated.truck.transport.com:15051
bash-4.4# peer channel join -b /opt/gopath/src/github.com/hyperledger/fabric/peer/transport-channel.block
2019-09-02 14:59:38.709 UTC [channelCmd] InitCmdFactory -> INFO 001 Endorser and orderer connections initialized
2019-09-02 14:59:39.209 UTC [channelCmd] executeJoin -> INFO 002 Successfully submitted proposal to join channel

~~~

### Join Channel ###

~~~
$ docker cp transport-cli:/opt/gopath/src/github.com/hyperledger/fabric/peer/transport-channel.block channel-artifacts/

$ docker exec -ti farmer-cli bash

//export CORE_PEER_LOCALMSPID=FarmerMSP
//export CORE_PEER_TLS_ROOTCERT_FILE=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/farmer.com/peers/apple.farmer.com/tls/ca.crt
//export CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/farmer.com/users/Admin@org3.example.com/msp

export CORE_PEER_ADDRESS=apple.farmer.com:7051

bash-4.4# peer channel join -b /opt/gopath/src/github.com/hyperledger/fabric/peer/channel-artifacts/transport-channel.block 
2019-08-30 07:56:13.403 UTC [channelCmd] InitCmdFactory -> INFO 001 Endorser and orderer connections initialized
2019-08-30 07:56:13.914 UTC [channelCmd] executeJoin -> INFO 002 Successfully submitted proposal to join channel
bash-4.4# peer channel list
2019-08-30 07:56:20.996 UTC [channelCmd] InitCmdFactory -> INFO 001 Endorser and orderer connections initialized
Channels peers has joined: 
transport-channel

bash-4.4# export CORE_PEER_ADDRESS=pear.farmer.com:8051
bash-4.4# peer channel join -b /opt/gopath/src/github.com/hyperledger/fabric/peer/channel-artifacts/transport-channel.block
2019-09-02 15:40:38.525 UTC [channelCmd] InitCmdFactory -> INFO 001 Endorser and orderer connections initialized
2019-09-02 15:40:39.066 UTC [channelCmd] executeJoin -> INFO 002 Successfully submitted proposal to join channel

bash-4.4# export CORE_PEER_ADDRESS=melon.farmer.com:9051
bash-4.4# peer channel join -b /opt/gopath/src/github.com/hyperledger/fabric/peer/channel-artifacts/transport-channel.block
2019-09-02 15:41:24.660 UTC [channelCmd] InitCmdFactory -> INFO 001 Endorser and orderer connections initialized
2019-09-02 15:41:25.152 UTC [channelCmd] executeJoin -> INFO 002 Successfully submitted proposal to join channel
bash-4.4# 


~~~


## Update Anchor Peer ##

~~~
$ docker exec -ti transport-cli bash

bash-4.4# export CORE_PEER_ADDRESS=cargo.truck.transport.com:14051

bash-4.4# peer channel update -o orderer.transport.com:7050 -c transport-channel -f channel-artifacts/TransportMSPanchors.tx --tls --cafile /opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/ordererOrganizations/transport.com/msp/tlscacerts/tlsca.transport.com-cert.pem 
2019-09-02 06:46:43.684 UTC [channelCmd] InitCmdFactory -> INFO 001 Endorser and orderer connections initialized
2019-09-02 06:46:43.733 UTC [channelCmd] update -> INFO 002 Successfully submitted channel update
~~~

~~~
$ docker exec -ti farmer-cli bash

bash-4.4# export CORE_PEER_ADDRESS=apple.farmer.com:7051

bash-4.4# peer channel update -o orderer.farmer.com:7050 -c transport-channel  -f channel-artifacts/FarmerMSPanchors.tx --tls --cafile /opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/ordererOrganizations/farmer.com/msp/tlscacerts/tlsca.farmer.com-cert.pem 
2019-09-02 06:50:52.632 UTC [channelCmd] InitCmdFactory -> INFO 001 Endorser and orderer connections initialized
2019-09-02 06:50:52.692 UTC [channelCmd] update -> INFO 002 Successfully submitted channel update
~~~

## ChainCode ##

### ChainCode on farmer.com ###

#### Package ChainCode ####

~~~
docker exec -ti farmer-cli bash

peer lifecycle chaincode package abstore.tar.gz --path /opt/github.com/hyperledger/fabric/chaincode/abstore/go/ --lang golang --label abstore_0

bash-4.4# peer lifecycle chaincode package abstore.tar.gz --path /opt/gopath/src/github.com/hyperledger/fabric-samples/chaincode/abstore/go --lang golang --label abstore_0
Error: error getting chaincode bytes: Error getting code code does not exist Could not open file open /opt/gopath/src/opt/gopath/src/github.com/hyperledger/fabric/chaincode/abstore/go: no such file or directory

bash-4.4# echo $GOPATH
/opt/gopath
bash-4.4# peer lifecycle chaincode package abstore.tar.gz --path github.com/hyperledger/fabric/chaincode/abstore/go --lang golang --label abstore_0


bash-4.4# peer lifecycle chaincode package abstore.tar.gz --path /opt/gopath/src/github.com/hyperledger/fabric/chaincode/abstore/go --lang golang --label abstore_0
Error: error getting chaincode bytes: Error getting code code does not exist Could not open file open /opt/gopath/src/opt/gopath/src/github.com/hyperledger/fabric/chaincode/abstore/go: no such file or directory
bash-4.4# peer lifecycle chaincode package abstore.tar.gz --path github.com/hyperledger/fabric/chaincode/abstore/go --lang golang --label abstore_0
bash-4.4# ls
abstore.tar.gz     channel-artifacts  crypto             scripts
bash-4.4# 

~~~

#### Install ChainCode ####

~~~
docker exec -ti farmer-cli bash

export CORE_PEER_ADDRESS=apple.farmer.com:7051
peer lifecycle chaincode install abstore.tar.gz
peer lifecycle chaincode queryinstalled


export CORE_PEER_ADDRESS=pear.farmer.com:8051
peer lifecycle chaincode install abstore.tar.gz
peer lifecycle chaincode queryinstalled


bash-4.4# export CORE_PEER_ADDRESS=apple.farmer.com:7051
bash-4.4# peer lifecycle chaincode install abstore.tar.gz
2019-09-03 06:18:24.281 UTC [cli.lifecycle.chaincode] submitInstallProposal -> INFO 001 Installed remotely: response:<status:200 payload:"\nJabstore_0:8f8afcac936a0959d9e840dae0d49b53ffc933a052abf71c54ef531d1315e59c\022\tabstore_0" > 
2019-09-03 06:18:24.283 UTC [cli.lifecycle.chaincode] submitInstallProposal -> INFO 002 Chaincode code package identifier: abstore_0:8f8afcac936a0959d9e840dae0d49b53ffc933a052abf71c54ef531d1315e59c
bash-4.4# ls
abstore.tar.gz     channel-artifacts  crypto             scripts
bash-4.4# peer lifecycle chaincode queryinstalled
Installed chaincodes on peer:
Package ID: abstore_0:8f8afcac936a0959d9e840dae0d49b53ffc933a052abf71c54ef531d1315e59c, Label: abstore_0
bash-4.4# export CORE_PEER_ADDRESS=pear.farmer.com:8051
bash-4.4# peer lifecycle chaincode install abstore.tar.gz
2019-09-03 06:18:58.503 UTC [cli.lifecycle.chaincode] submitInstallProposal -> INFO 001 Installed remotely: response:<status:200 payload:"\nJabstore_0:8f8afcac936a0959d9e840dae0d49b53ffc933a052abf71c54ef531d1315e59c\022\tabstore_0" > 
2019-09-03 06:18:58.505 UTC [cli.lifecycle.chaincode] submitInstallProposal -> INFO 002 Chaincode code package identifier: abstore_0:8f8afcac936a0959d9e840dae0d49b53ffc933a052abf71c54ef531d1315e59c
bash-4.4# peer lifecycle chaincode queryinstalled
Installed chaincodes on peer:
Package ID: abstore_0:8f8afcac936a0959d9e840dae0d49b53ffc933a052abf71c54ef531d1315e59c, Label: abstore_0
bash-4.4# 

~~~

* **Package ID: abstore_0:8f8afcac936a0959d9e840dae0d49b53ffc933a052abf71c54ef531d1315e59c**

* **Label: abstore_0**
#### Approve ChainCode ####

~~~
peer lifecycle chaincode approveformyorg --channelID transport-channel --name abstore --version 0 --init-required --package-id ${PACKAGE_ID} --sequence 0 --waitForEvent
~~~

### ChainCode on transport.com ###


~~~
HAIMHUAN-M-40YV:food-network haimhuan$ docker exec -ti farmer-cli bash
bash-4.4# peer
Usage:
  peer [command]

Available Commands:
  chaincode   Operate a chaincode: install|instantiate|invoke|package|query|signpackage|upgrade|list.
  channel     Operate a channel: create|fetch|join|list|update|signconfigtx|getinfo.
  help        Help about any command
  lifecycle   Perform _lifecycle operations
  logging     Logging configuration: getlevel|setlevel|getlogspec|setlogspec|revertlevels.
  node        Operate a peer node: start|status.
  version     Print fabric peer version.

Flags:
  -h, --help   help for peer

Use "peer [command] --help" for more information about a command.
bash-4.4# peer lifecycle chaincode queryinstalled
Installed chaincodes on peer:
bash-4.4# 
~~~

## Q&A ##

### Clean HF Networks ###
If you can't recover some error, try to clean HF and re-create it
~~~ shell
docker stop $(docker ps -aq)
docker rm $(docker ps -aq)
docker volume prune -f
~~~

### Join channel Failed ###

**Q**: In docker log shows "permission deined" when call "peer channel join .." in cli
~~~
cargo.truck.transport.com           | 2019-08-27 15:52:43.697 UTC [blocksProvider] DeliverBlocks -> ERRO 0b4 [transport-channel] Got error &{FORBIDDEN}
orderer.government.com              | 2019-08-27 15:52:43.914 UTC [common.deliver] deliverBlocks -> WARN 06e [channel: transport-channel] Client authorization revoked for deliver request from 192.168.208.6:59826: implicit policy evaluation failed - 0 sub-policies were satisfied, but this policy requires 1 of the 'Readers' sub-policies to be satisfied: permission denied
~~~

**A**: Should enable "EnableNodeOUs" in crypto-conf.yaml.

~~~
PeerOrgs:
  - Name: farmer
    Domain: farmer.com
    EnableNodeOUs: true
    CA:
      Hostname:  ca
    Specs:
      - Hostname: apple
      - Hostname: pear
      - Hostname: melon
    Users:
      Count: 3
~~~

After run **cryptogen generate**, one file named "config.yaml" will be created in msp

~~~
$ ls crypto-config/peerOrganizations/farmer.com/msp/

admincerts	cacerts		config.yaml	tlscacerts
~~~

~~~
$ cat crypto-config/peerOrganizations/farmer.com/msp/config.yaml 

NodeOUs:
  Enable: true
  ClientOUIdentifier:
    Certificate: cacerts/ca.farmer.com-cert.pem
    OrganizationalUnitIdentifier: client
  PeerOUIdentifier:
    Certificate: cacerts/ca.farmer.com-cert.pem
    OrganizationalUnitIdentifier: peer
~~~

### Failed validating identity message: Peer Identity / No MSP found able to do that ###

**Q**: Peer refrigerated.truck.transport.com logging error after cargo.truck.transport.com join the channel


~~~
cargo.truck.transport.com           | 2019-09-02 06:50:23.425 UTC [gossip.comm] func1 -> WARN 056 apple.farmer.com:7051, PKIid:0b578fa9a9e6a4fdd23a79cffad85d7446d199082478f9cb9078285cd3877d31 isn't responsive: EOF
cargo.truck.transport.com           | 2019-09-02 06:50:23.428 UTC [gossip.comm] func1 -> WARN 057 apple.farmer.com:7051, PKIid:ef631cac38783e6c614a7c87d5c377d66e6813646859ea906a42258957ffdf07 isn't responsive: EOF
apple.farmer.com                    | 2019-09-02 06:50:23.441 UTC [comm.grpc.server] 1 -> INFO 05f unary call completed grpc.service=gossip.Gossip grpc.method=Ping grpc.request_deadline=2019-09-02T06:50:25.439Z grpc.peer_address=192.168.16.5:40090 grpc.peer_subject="CN=cargo.truck.transport.com,L=San Francisco,ST=California,C=US" grpc.code=OK grpc.call_duration=189.3µs
refrigerated.truck.transport.com    | 2019-09-02 06:50:24.642 UTC [peer.gossip.mcs] Verify -> ERRO 022 Failed getting validated identity from peer identity [Peer Identity [0a 09 46 61 72 6d 65 72 4d 53 50 12 92 06 2d 2d 2d 2d 2d 42 45 47 49 4e 20 43 45 52 54 49 46 49 43 41 54 45 2d 2d 2d 2d 2d 0a 4d 49 49 43 46 7a 43 43 41 62 32 67 41 77 49 42 41 67 49 52 41 4e 50 46 6c 6a 2f 34 2f 62 39 41 74 44 36 65 45 52 32 4c 37 47 51 77 43 67 59 49 4b 6f 5a 49 7a 6a 30 45 41 77 49 77 5a 7a 45 4c 0a 4d 41 6b 47 41 31 55 45 42 68 4d 43 56 56 4d 78 45 7a 41 52 42 67 4e 56 42 41 67 54 43 6b 4e 68 62 47 6c 6d 62 33 4a 75 61 57 45 78 46 6a 41 55 42 67 4e 56 42 41 63 54 44 56 4e 68 62 69 42 47 0a 63 6d 46 75 59 32 6c 7a 59 32 38 78 45 7a 41 52 42 67 4e 56 42 41 6f 54 43 6d 5a 68 63 6d 31 6c 63 69 35 6a 62 32 30 78 46 6a 41 55 42 67 4e 56 42 41 4d 54 44 57 4e 68 4c 6d 5a 68 63 6d 31 6c 0a 63 69 35 6a 62 32 30 77 48 68 63 4e 4d 54 6b 77 4f 54 41 79 4d 44 59 79 4e 44 41 77 57 68 63 4e 4d 6a 6b 77 4f 44 4d 77 4d 44 59 79 4e 44 41 77 57 6a 42 6b 4d 51 73 77 43 51 59 44 56 51 51 47 0a 45 77 4a 56 55 7a 45 54 4d 42 45 47 41 31 55 45 43 42 4d 4b 51 32 46 73 61 57 5a 76 63 6d 35 70 59 54 45 57 4d 42 51 47 41 31 55 45 42 78 4d 4e 55 32 46 75 49 45 5a 79 59 57 35 6a 61 58 4e 6a 0a 62 7a 45 4e 4d 41 73 47 41 31 55 45 43 78 4d 45 63 47 56 6c 63 6a 45 5a 4d 42 63 47 41 31 55 45 41 78 4d 51 59 58 42 77 62 47 55 75 5a 6d 46 79 62 57 56 79 4c 6d 4e 76 62 54 42 5a 4d 42 4d 47 0a 42 79 71 47 53 4d 34 39 41 67 45 47 43 43 71 47 53 4d 34 39 41 77 45 48 41 30 49 41 42 4b 49 4e 59 6c 65 51 32 36 57 31 7a 76 72 46 76 6d 56 77 59 63 30 35 35 43 4a 4a 74 5a 37 38 73 6b 6e 6b 0a 4c 54 6e 36 37 53 4e 49 5a 6c 6a 6c 65 63 7a 74 51 72 53 56 6c 57 76 48 7a 42 45 79 6d 50 35 72 42 6b 55 7a 74 54 57 50 61 30 4d 31 39 43 62 32 6a 39 79 6a 54 54 42 4c 4d 41 34 47 41 31 55 64 0a 44 77 45 42 2f 77 51 45 41 77 49 48 67 44 41 4d 42 67 4e 56 48 52 4d 42 41 66 38 45 41 6a 41 41 4d 43 73 47 41 31 55 64 49 77 51 6b 4d 43 4b 41 49 50 67 59 2f 65 2b 4c 6a 64 41 4d 4e 58 70 68 0a 61 6d 54 41 6e 68 37 35 39 56 74 6d 4e 42 37 59 61 49 36 6e 33 6f 51 55 71 77 31 57 4d 41 6f 47 43 43 71 47 53 4d 34 39 42 41 4d 43 41 30 67 41 4d 45 55 43 49 51 43 59 79 38 70 66 55 2f 38 74 0a 74 45 48 4a 57 32 65 2b 50 64 70 5a 31 6e 2b 5a 45 41 4c 6e 4c 51 6e 4e 37 53 70 53 73 4c 33 30 50 77 49 67 4b 48 37 71 64 30 6b 63 4c 51 73 72 4a 33 37 51 46 4a 76 42 5a 33 69 42 44 69 6d 53 0a 76 43 6e 45 74 74 73 35 67 56 30 4b 74 6c 34 3d 0a 2d 2d 2d 2d 2d 45 4e 44 20 43 45 52 54 49 46 49 43 41 54 45 2d 2d 2d 2d 2d 0a] cannot be validated. No MSP found able to do that.]
refrigerated.truck.transport.com    | 2019-09-02 06:50:24.642 UTC [gossip.gossip] handleMessage -> WARN 023 Failed validating identity message: Peer Identity [0a 09 46 61 72 6d 65 72 4d 53 50 12 92 06 2d 2d 2d 2d 2d 42 45 47 49 4e 20 43 45 52 54 49 46 49 43 41 54 45 2d 2d 2d 2d 2d 0a 4d 49 49 43 46 7a 43 43 41 62 32 67 41 77 49 42 41 67 49 52 41 4e 50 46 6c 6a 2f 34 2f 62 39 41 74 44 36 65 45 52 32 4c 37 47 51 77 43 67 59 49 4b 6f 5a 49 7a 6a 30 45 41 77 49 77 5a 7a 45 4c 0a 4d 41 6b 47 41 31 55 45 42 68 4d 43 56 56 4d 78 45 7a 41 52 42 67 4e 56 42 41 67 54 43 6b 4e 68 62 47 6c 6d 62 33 4a 75 61 57 45 78 46 6a 41 55 42 67 4e 56 42 41 63 54 44 56 4e 68 62 69 42 47 0a 63 6d 46 75 59 32 6c 7a 59 32 38 78 45 7a 41 52 42 67 4e 56 42 41 6f 54 43 6d 5a 68 63 6d 31 6c 63 69 35 6a 62 32 30 78 46 6a 41 55 42 67 4e 56 42 41 4d 54 44 57 4e 68 4c 6d 5a 68 63 6d 31 6c 0a 63 69 35 6a 62 32 30 77 48 68 63 4e 4d 54 6b 77 4f 54 41 79 4d 44 59 79 4e 44 41 77 57 68 63 4e 4d 6a 6b 77 4f 44 4d 77 4d 44 59 79 4e 44 41 77 57 6a 42 6b 4d 51 73 77 43 51 59 44 56 51 51 47 0a 45 77 4a 56 55 7a 45 54 4d 42 45 47 41 31 55 45 43 42 4d 4b 51 32 46 73 61 57 5a 76 63 6d 35 70 59 54 45 57 4d 42 51 47 41 31 55 45 42 78 4d 4e 55 32 46 75 49 45 5a 79 59 57 35 6a 61 58 4e 6a 0a 62 7a 45 4e 4d 41 73 47 41 31 55 45 43 78 4d 45 63 47 56 6c 63 6a 45 5a 4d 42 63 47 41 31 55 45 41 78 4d 51 59 58 42 77 62 47 55 75 5a 6d 46 79 62 57 56 79 4c 6d 4e 76 62 54 42 5a 4d 42 4d 47 0a 42 79 71 47 53 4d 34 39 41 67 45 47 43 43 71 47 53 4d 34 39 41 77 45 48 41 30 49 41 42 4b 49 4e 59 6c 65 51 32 36 57 31 7a 76 72 46 76 6d 56 77 59 63 30 35 35 43 4a 4a 74 5a 37 38 73 6b 6e 6b 0a 4c 54 6e 36 37 53 4e 49 5a 6c 6a 6c 65 63 7a 74 51 72 53 56 6c 57 76 48 7a 42 45 79 6d 50 35 72 42 6b 55 7a 74 54 57 50 61 30 4d 31 39 43 62 32 6a 39 79 6a 54 54 42 4c 4d 41 34 47 41 31 55 64 0a 44 77 45 42 2f 77 51 45 41 77 49 48 67 44 41 4d 42 67 4e 56 48 52 4d 42 41 66 38 45 41 6a 41 41 4d 43 73 47 41 31 55 64 49 77 51 6b 4d 43 4b 41 49 50 67 59 2f 65 2b 4c 6a 64 41 4d 4e 58 70 68 0a 61 6d 54 41 6e 68 37 35 39 56 74 6d 4e 42 37 59 61 49 36 6e 33 6f 51 55 71 77 31 57 4d 41 6f 47 43 43 71 47 53 4d 34 39 42 41 4d 43 41 30 67 41 4d 45 55 43 49 51 43 59 79 38 70 66 55 2f 38 74 0a 74 45 48 4a 57 32 65 2b 50 64 70 5a 31 6e 2b 5a 45 41 4c 6e 4c 51 6e 4e 37 53 70 53 73 4c 33 30 50 77 49 67 4b 48 37 71 64 30 6b 63 4c 51 73 72 4a 33 37 51 46 4a 76 42 5a 33 69 42 44 69 6d 53 0a 76 43 6e 45 74 74 73 35 67 56 30 4b 74 6c 34 3d 0a 2d 2d 2d 2d 2d 45 4e 44 20 43 45 52 54 49 46 49 43 41 54 45 2d 2d 2d 2d 2d 0a] cannot be validated. No MSP found able to do that.
refrigerated.truck.transport.com    | Failed verifying message
refrigerated.truck.transport.com    | github.com/hyperledger/fabric/gossip/gossip.(*certStore).validateIdentityMsg
refrigerated.truck.transport.com    | 	/go/src/github.com/hyperledger/fabric/gossip/gossip/certstore.go:105
refrigerated.truck.transport.com    | github.com/hyperledger/fabric/gossip/gossip.(*certStore).handleMessage
refrigerated.truck.transport.com    | 	/go/src/github.com/hyperledger/fabric/gossip/gossip/certstore.go:77
refrigerated.truck.transport.com    | github.com/hyperledger/fabric/gossip/gossip.(*gossipServiceImpl).handleMessage
refrigerated.truck.transport.com    | 	/go/src/github.com/hyperledger/fabric/gossip/gossip/gossip_impl.go:391
refrigerated.truck.transport.com    | github.com/hyperledger/fabric/gossip/gossip.(*gossipServiceImpl).acceptMessages
refrigerated.truck.transport.com    | 	/go/src/github.com/hyperledger/fabric/gossip/gossip/gossip_impl.go:318
refrigerated.truck.transport.com    | runtime.goexit
refrigerated.truck.transport.com    | 	/usr/local/go/src/runtime/asm_amd64.s:1333
refrigerated.truck.transport.com    | github.com/hyperledger/fabric/gossip/gossip.(*certStore).handleMessage
refrigerated.truck.transport.com    | 	/go/src/github.com/hyperledger/fabric/gossip/gossip/certstore.go:78
refrigerated.truck.transport.com    | github.com/hyperledger/fabric/gossip/gossip.(*gossipServiceImpl).handleMessage
refrigerated.truck.transport.com    | 	/go/src/github.com/hyperledger/fabric/gossip/gossip/gossip_impl.go:391
refrigerated.truck.transport.com    | github.com/hyperledger/fabric/gossip/gossip.(*gossipServiceImpl).acceptMessages
refrigerated.truck.transport.com    | 	/go/src/github.com/hyperledger/fabric/gossip/gossip/gossip_impl.go:318
refrigerated.truck.transport.com    | runtime.goexit
refrigerated.truck.transport.com    | 	/usr/local/go/src/runtime/asm_amd64.s:1333
~~~

**A**:
The error will not loggin after refrigerated.truck.transport.com join the channel.

All peers in same organization should join the channel.


## Channel Lifecycle ##
* Define Channel configuration
    * Output: configtx.yaml
* Generate Channel Transaction
    * Command: configtxgen
    * Input: configtx.yaml
    * Output: Channel Transaction File (*.tx)
* Create Channel
    * Command: peer channel create
    * Input: 
        * Channel ID
        * Channel Transaction File
    * Output:
        * Channel Genesis Block (channel_id.block)
* Joining peer to Channel
    * command: peer channel join
    * Input: 
        * Channel Genesis Block (channel_id.block)
* Add Organization to Channel
    * Command: peer channel update



## ChainCode Lifecyccle ##

* Setup- create the necessary application objects
* Package - create a chaincode package from your source code
* Install - install the chaincode package on your peers
* Approve a definition for organization - each organization needs to approve a chaincode definition in order to use the chaincode
* Commit the definition to a channel - After a sufficient number of organizations have approved a chaincode definition, the definition can be committed to a channel by one organization
* Initialize - (Optional) initialize the chaincode and start the chaincode container

## Referecnes ##
[Understanding Hyperledger Fabric — Channel Lifecycle](https://medium.com/kokster/understanding-hyperledger-fabric-channel-lifecycle-a546670646e3)

[fabric-client: How to install and start your chaincode](https://fabric-sdk-node.github.io/master/tutorial-chaincode-lifecycle.html)


