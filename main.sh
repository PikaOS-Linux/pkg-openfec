# Clone Upstream
git clone https://github.com/roc-streaming/openfec -b v1.4.2.9
rm -rfv ./openfec/debian
cp -rvf ./debian ./openfec/
cd ./openfec

for i in ../patches/*.patch; do patch -Np1 -i $i ;done

LOGNAME=root dh_make --createorig -y -l -p openfec_1.4.2.9

# Get build deps
apt-get build-dep ./ -y

# Build package
dpkg-buildpackage --no-sign

# Move the debs to output
cd ../
mkdir -p ./output
mv ./*.deb ./output/
