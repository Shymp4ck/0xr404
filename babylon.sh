#!/bin/bash
exists()
{
  command -v "$1" >/dev/null 2>&1
}
if exists curl; then
echo ''
else
  sudo apt update && sudo apt install curl -y < "/dev/null"
fi
bash_profile=$HOME/.bash_profile
if [ -f "$bash_profile" ]; then
    . $HOME/.bash_profile
fi
sleep 1 && curl -s https://api.nodes.guru/logo.sh | bash && sleep 1

NODE=Babylon
export DAEMON_HOME=$HOME/.babylond
export DAEMON_NAME=babylond
CHAIN_ID=bbn-test-3
echo 'export CHAIN_ID='\"${CHAIN_ID}\" >> $HOME/.bash_profile

if [ ! $VALIDATOR ]; then
    read -p "Enter validator name: " VALIDATOR
    echo 'export VALIDATOR='\"${VALIDATOR}\" >> $HOME/.bash_profile
fi
read -p "Enter your email address: " EMAIL
read -p "Enter a description of your validator: " DESCRIPTION
echo 'source $HOME/.bashrc' >> $HOME/.bash_profile
source $HOME/.bash_profile
sleep 1
cd $HOME
sudo apt update
sudo apt install make clang pkg-config lz4 libssl-dev build-essential git jq ncdu bsdmainutils htop -y < "/dev/null"

echo -e '\n\e[42mInstall Go\e[0m\n' && sleep 1
cd $HOME
VERSION=1.21.6
wget -O go.tar.gz https://go.dev/dl/go$VERSION.linux-amd64.tar.gz
sudo rm -rf /usr/local/go && sudo tar -C /usr/local -xzf go.tar.gz && rm go.tar.gz
echo 'export GOROOT=/usr/local/go' >> $HOME/.bash_profile
echo 'export GOPATH=$HOME/go' >> $HOME/.bash_profile
echo 'export GO111MODULE=on' >> $HOME/.bash_profile
echo 'export PATH=$PATH:/usr/local/go/bin:$HOME/go/bin' >> $HOME/.bash_profile && . $HOME/.bash_profile
go version

echo -e '\n\e[42mInstall software\e[0m\n' && sleep 1
cd $HOME
rm -rf babylon
git clone https://github.com/babylonchain/babylon.git
cd babylon
git checkout v0.8.4
make build
sudo mv ./build/babylond  /usr/local/bin/ || exit
sleep 1
cd $HOME
$DAEMON_NAME init "$VALIDATOR" --chain-id $CHAIN_ID
$DAEMON_NAME config set client chain-id ${CHAIN_ID}
$DAEMON_NAME config set client keyring-backend test
SEEDS="49b4685f16670e784a0fe78f37cd37d56c7aff0e@3.14.89.82:26656,9cb1974618ddd541c9a4f4562b842b96ffaf1446@3.16.63.237:26656"
#PEERS="a59865bac63119ecd26e894a70ff9b5b36f07d7d@101.46.137.130:26656,52820c8ea646454529c43d6a8d2e1e30bf50cb46@185.227.135.168:26656,cd99a0bf859e5f44f41c2316dd25a5fb690941db@154.53.55.128:26656,a3d0e46ba4715079dc796c130994b026d9c7f126@109.199.108.19:26656,d5e3731e3c460270d93a7590df7dcf1b4277f1f3@45.85.146.159:26656,e3d53ab75759448ef1818641c805c8e34d24ace2@194.233.95.66:26656,374179060d2b52beef20a16d91964104e1a76709@37.60.249.119:26656,66af16cf6b888ef0c631cc293d26f3cb06a04b4a@194.163.177.76:26656,12f9061449bd4e3a62d01c5b3435a09c79b7bee2@54.204.198.231:26656,53479566a96fba20ecc7e44f0251c66656777d59@178.18.253.146:26656,9242051637ea91aff3a23fc2b0278d5048e07ae9@31.220.75.195:26656,3e0cdd50930ad80f9fb80b84e529dda4411e2ed4@173.212.215.177:26656,8e336a7fd41a4af33113791124ab833e8ecb46ae@185.187.170.63:26656,fb05a42074eb397312708682a95ddef792c4b63b@185.217.127.47:26656,4edc6cbd46a3de2b0c710298bf403e06d5e7725d@209.126.3.74:26656,5476f04c4ff44d89289f5ca6938e0f4291cac864@154.12.244.235:26656,bec7e26f83cdd618117222df98179dde5267c320@5.199.133.245:26656,1765b6edbe1707e7fb2e4de35fbb43fa617690ba@213.199.45.106:26656,13cefaad47176760b3040ce4a54ea78fd4346350@46.4.105.114:20735,060846d3870cd79e52c8302cecbdb92c47950668@37.120.178.36:26656,702228072fc2df5be0ea37733dc72116cb72a870@109.199.124.233:26656,eb0ef2428e4540bb00b797824e052c7933263bf7@84.247.183.75:26656,785cf2614d881096ceebb4446e642bc9d962f5f3@154.12.245.38:26656,21d9dd05fa924cbcdaf501b92b74bf106af29c95@89.58.32.218:25000,16c7e580da86a32162428304e7f75b716565e172@109.199.122.14:26656,54a216b85367cd1ace074f1c893996ddc5c11334@213.199.46.145:26656,1a0af60b43129f4d73705547c3a6e6b94db9713c@5.182.33.155:26656,3513b9eedec2190a7fda6e3f3d9b3baa63bf215d@109.123.232.86:26656,8e8d46f63fe9f780cbb05b7100b700fd34621e71@161.97.158.235:26656,a5b320791a8b82ee879d9d8fe0f71ae8e4f2c415@38.242.231.88:26656,a747fec310ed2b4193c02d36d2105ac6f582aa0c@109.199.117.89:26656,e7848e82dc4ed1e84ed984e1b5fafbea0b2dd88e@109.199.125.212:26656,3d9388e82d76fa4c49c59677b360237552a147a7@109.199.111.55:26656,ee86509efe884fa332513e845b9d0f656ea74cf3@84.247.138.89:26656,2ee26c25e190c200517a359209f079b00dab3420@109.199.124.226:26656,1a34a682210d72380c24af5e93e84f751983e396@207.180.193.69:26656,49928d23fd8d39d8944d8998cfbc21bd24f33523@31.220.88.222:26656,fa3ee91b6ee163eac98b78780754efba8f12ba50@45.41.204.210:26656,b845d57ec7090860afb04df2fd3b69d6076c21da@65.109.32.125:26656,b616a1cc9f0d187499a7e80e65112e486d396103@62.171.172.242:26656,01b8c4919b6238eb92d9087539c2e7c4dc6abd59@74.118.136.139:26656,b79179f00d657db37464fc46bc6a3c463c174f1f@176.9.11.189:26656,ed85792e8d3a60bda70d7277da0dc951da0a424a@173.212.251.207:26656,2b192c278abb626af9465c75b94f932d48a391a8@185.218.125.65:26656,7392e35be0a167556eef162ec839461149ff0d29@62.171.170.175:26656,93187d76f68379e638a765d29085b3ba9563d9a2@109.199.124.225:26656,d63a03bd00c211acf1d538bbe2577238f66d2d49@75.119.138.34:26656,48e4119697326fbdf02fb6639a7ecd2ae53e062c@38.242.253.174:26656,f999e0e4c3cdca471a0c482fe9c0bc01b63b53bf@144.76.14.158:20735,d3b2c3323a1eef519cec232d209710d1f0539daa@88.198.57.55:26656,0907bf7627dcb1740cb8cce32ec241ed43802eec@167.86.74.162:26656,8cb145885b43e77007cbb1bf661f32854678a360@173.212.251.224:26656,c3d87174c225d149838b3ea7d89d0e5a480da35e@136.243.150.76:26656,3e8b4282a845b3fa3d81833fc7d8ddda957cb5d1@144.126.156.170:26656,76a4440ec50f1ec1307fc70cc2a13221ce88a483@65.109.118.244:26656,d9d09c003bf5465c68c780f67e8d8ace996ea9f3@154.53.32.169:26656,f840a2065d031569550fa71d8a2b79cdebdd359a@158.220.85.35:26656,74190795eb8a9b87cdd144d58764633d30ab4275@82.219.13.245:26656,f53c5a6184f33a8c9a1d4ecd39b7982261dbbe9d@173.249.17.188:26656,dcbb3effbecbf1e42c64ff11ea61dca805612afc@144.126.138.81:26656,6563d4a89eeb574a635f74b6ed36d70cdd437656@173.249.35.247:26656,4b5ed6e8caed5bbaa7669d113f92efbb6641f83c@84.247.139.5:26656,428e8f6331dd4aae61157eb5e1d56d3c3f379006@213.199.39.82:26656,c0a9d621a78fbf8be1960f3ed8edeb38e52a50a0@185.193.17.159:20656,5bd45f1ac56314e75719baef76ee6a51e66a5b2d@89.58.37.76:26656,32d075953958ce60714eabc06d7693b5632aa25c@84.247.139.14:26656,6632c44bd71a583e9f6682b3a62fc3e9160968fd@144.91.123.67:20656,deb912ef6dc7e69e902c6339d7479c6733050f1f@161.97.71.208:20656,2a48cab6265889d43f6ed54e05cfaeab27ada274@161.97.157.215:26656,79e00df888f58754175f461095086d4ac2bc0349@109.199.124.231:26656,c5e5955f569c7e514e9a42c03ce9ea880eef3b06@134.119.205.117:26656,2e53b8bea549c2c3128dc43cfc9e7dce867be42f@178.124.188.210:26656,768c9b6ba484084e2190378031fa7e00e034d5d7@18.208.126.139:26656,7d7aad93096f4b1dae8c11e3801c9ba2b55df25c@194.233.95.139:26656,70e48b8da492ea80e4c2d03434e4a3700a0df267@84.46.252.156:26656,69c1b7e1eb114703733c3000baa6c008ebc70073@65.109.113.233:20656"

sed -i.bak -e "s/^minimum-gas-prices *=.*/minimum-gas-prices = \"0.00001ubbn\"/" $DAEMON_HOME/config/app.toml
sed -i -e "s/^network *=.*/network = \"signet\"/" $DAEMON_HOME/config/app.toml
sed -i.bak -e "s/^seeds *=.*/seeds = \"${SEEDS}\"/" $DAEMON_HOME/config/config.toml
#sed -i -e "s/^persistent_peers *=.*/persistent_peers = \"${PEERS}\"/" $DAEMON_HOME/config/config.toml
sed -i -e "s/^timeout_commit *=.*/timeout_commit = \"30s\"/" $DAEMON_HOME/config/config.toml
sed -i -e "s/^external_address *=.*/external_address = \"$(curl -s ipinfo.io/ip):26656\"/" $DAEMON_HOME/config/config.toml
pruning="custom"
pruning_keep_recent="100"
pruning_keep_every="0"
pruning_interval="10"
sed -i -e "s/^pruning *=.*/pruning = \"$pruning\"/" $DAEMON_HOME/config/app.toml
sed -i -e "s/^pruning-keep-recent *=.*/pruning-keep-recent = \"$pruning_keep_recent\"/" $DAEMON_HOME/config/app.toml
#sed -i -e "s/^pruning-keep-every *=.*/pruning-keep-every = \"$pruning_keep_every\"/" $DAEMON_HOME/config/app.toml
sed -i -e "s/^pruning-interval *=.*/pruning-interval = \"$pruning_interval\"/" $DAEMON_HOME/config/app.toml
sed -i -e "s/indexer *=.*/indexer = \"null\"/g" $DAEMON_HOME/config/config.toml

wget -O $HOME/.babylond/config/genesis.json https://api.nodes.guru/babylon/genesis.json
$DAEMON_NAME tendermint unsafe-reset-all

echo -e '\n\e[42mInstall cosmovisor\e[0m\n' && sleep 1
#install cosmovisor
go install cosmossdk.io/tools/cosmovisor/cmd/cosmovisor@latest

cosmovisor init /usr/local/bin/babylond
cosmovisor version
$DAEMON_NAME version
CURRENT=$(ls -la $DAEMON_HOME/cosmovisor/current | awk {'print $NF'})
mkdir -p $CURRENT/bin
mv /usr/local/bin/babylond $CURRENT/bin
ln -s $DAEMON_HOME/cosmovisor/current/bin/$DAEMON_NAME /usr/local/bin/$DAEMON_NAME

echo -e '\n\e[42mDownloading a snapshot\e[0m\n' && sleep 1
curl https://snapshots.nodes.guru/babylon/babylon.tar.lz4 | lz4 -dc - | tar -xf - -C $HOME/.babylond
wget -O $HOME/.babylond/config/addrbook.json https://snapshots.nodes.guru/babylon/addrbook.json

echo -e '\n\e[42mRunning\e[0m\n' && sleep 1
echo -e '\n\e[42mCreating a service\e[0m\n' && sleep 1

echo "[Unit]
Description=cosmovisor
After=network-online.target

[Service]
User=$USER
ExecStart=$(which cosmovisor) run start
Restart=always
RestartSec=3
LimitNOFILE=4096
Environment="DAEMON_NAME=$DAEMON_NAME"
Environment="DAEMON_HOME=$DAEMON_HOME"
Environment="UNSAFE_SKIP_BACKUP=true"
Environment="DAEMON_ALLOW_DOWNLOAD_BINARIES=true"
Environment="DAEMON_RESTART_AFTER_UPGRADE=true"

[Install]
WantedBy=multi-user.target" >$DAEMON_NAME.service
sudo mv $HOME/$DAEMON_NAME.service /etc/systemd/system
sudo tee <<EOF >/dev/null /etc/systemd/journald.conf
Storage=persistent
EOF
echo -e '\n\e[42mChecking a ports\e[0m\n' && sleep 1
#CHECK PORTS
PORT=333
if ss -tulpen | awk '{print $5}' | grep -q ":26656$" ; then
    echo -e "\e[31mPort 26656 already in use.\e[39m"
    sleep 2
    sed -i -e "s|:26656\"|:${PORT}56\"|g" $DAEMON_HOME/config/config.toml
    echo -e "\n\e[42mPort 26656 changed to ${PORT}56.\e[0m\n"
    sleep 2
fi
if ss -tulpen | awk '{print $5}' | grep -q ":26657$" ; then
    echo -e "\e[31mPort 26657 already in use\e[39m"
    sleep 2
    sed -i -e "s|:26657\"|:${PORT}57\"|" $DAEMON_HOME/config/config.toml
    echo -e "\n\e[42mPort 26657 changed to ${PORT}57.\e[0m\n"
    sleep 2
    $DAEMON_NAME config set client node tcp://localhost:${PORT}57
fi
if ss -tulpen | awk '{print $5}' | grep -q ":26658$" ; then
    echo -e "\e[31mPort 26658 already in use.\e[39m"
    sleep 2
    sed -i -e "s|:26658\"|:${PORT}58\"|" $DAEMON_HOME/config/config.toml
    echo -e "\n\e[42mPort 26658 changed to ${PORT}58.\e[0m\n"
    sleep 2
fi
if ss -tulpen | awk '{print $5}' | grep -q ":6060$" ; then
    echo -e "\e[31mPort 6060 already in use.\e[39m"
    sleep 2
    sed -i -e "s|:6060\"|:${PORT}60\"|" $DAEMON_HOME/config/config.toml
    echo -e "\n\e[42mPort 6060 changed to ${PORT}60.\e[0m\n"
    sleep 2
fi
if ss -tulpen | awk '{print $5}' | grep -q ":1317$" ; then
    echo -e "\e[31mPort 1317 already in use.\e[39m"
    sleep 2
    sed -i -e "s|:1317\"|:${PORT}17\"|" $DAEMON_HOME/config/config.toml
    echo -e "\n\e[42mPort 1317 changed to ${PORT}17.\e[0m\n"
    sleep 2
fi
if ss -tulpen | awk '{print $5}' | grep -q ":9090$" ; then
    echo -e "\e[31mPort 9090 already in use.\e[39m"
    sleep 2
    sed -i -e "s|:9090\"|:${PORT}90\"|" $DAEMON_HOME/config/config.toml
    echo -e "\n\e[42mPort 9090 changed to ${PORT}90.\e[0m\n"
    sleep 2
fi

#echo -e '\n\e[42mRunning a service\e[0m\n' && sleep 1
sudo systemctl restart systemd-journald
sudo systemctl daemon-reload
sudo systemctl enable $DAEMON_NAME

echo -e '\n\e[42mGreating a wallet ...\e[0m\n' && sleep 1
mkdir -p $HOME/.backup_babylon
date >> $HOME/.backup_babylon/wallet.txt
babylond keys add wallet &>>$HOME/.backup_babylon/wallet.txt
sleep 2
babylond create-bls-key $(babylond keys show wallet -a)
sleep 2
cat $HOME/.backup_babylon/wallet.txt
echo ""
echo -e "\033[41m\033[30mPLEASE SAVE YOUR MNEMONIC AND USE THIS WALLET TO CREATE A VALIDATOR \033[0m\n"
sleep 5
tee $HOME/babylon/validator.json > /dev/null << EOF
{
  "pubkey": $(babylond tendermint show-validator),
  "amount": "1000000ubbn",
  "moniker": "${VALIDATOR}",
  "identity": "",
  "website": "",
  "security": "${EMAIL}",
  "details": "${DESCRIPTION}",
  "commission-rate": "0.10",
  "commission-max-rate": "0.20",
  "commission-max-change-rate": "0.01",
  "min-self-delegation": "1"
}
EOF
sudo systemctl restart $DAEMON_NAME


echo -e '\n\e[42mCheck node status\e[0m\n' && sleep 1
if [[ `service $DAEMON_NAME status | grep active` =~ "running" ]]; then
  echo -e "Your $NODE node \e[32minstalled and works\e[39m!"
  echo -e "You can check node status by the command \e[7mservice $DAEMON_NAME status\e[0m"
  echo -e "Press \e[7mQ\e[0m for exit from status menu"
else
  echo -e "Your $NODE node \e[31mwas not installed correctly\e[39m, please reinstall."
fi

