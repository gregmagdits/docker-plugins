#echo "export GOPATH=$HOME/go" >> ~/.profile
#echo "export PATH=$PATH:/usr/local/go/bin" >> ~/.profile
export GOPATH=$HOME/go
export PATH=$PATH:/usr/local/go/bin
mkdir -p ~/go/src/github.com/gregmagdits 
mkdir ~/go/pkg 
mkdir ~/go/bin 
cd ~/go/src/github.com/gregmagdits 
git clone https://github.com/gregmagdits/dockerhook.git 
cd dockerhook
go get 
go build
cd ~/go
