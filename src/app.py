import os
import json
from web3 import Web3
from pathlib import Path
from dotenv import load_dotenv
import streamlit as st

load_dotenv()

w3 = Web3(Web3.HTTPProvider(os.getenv("WEB3_PROVIDER_URI")))
def load_contract():

    # Load the contract ABI
    with open(Path('./abi.json')) as f:
        abi = json.load(f)

    # Set the contract address (this is the address of the deployed contract)
    contract_address = w3.toChecksumAddress(os.getenv("SMART_CONTRACT_ADDRESS"))
    contract = w3.eth.contract(address=contract_address, abi=abi)
    return contract

st.title('Check Membership')

address = st.text_input('Address', value='0x0000000000000000000000000000000000000000')


if st.button('Check Membership'):
    contract = load_contract()
    add = w3.toChecksumAddress(address)
    gold = contract.functions.balanceOf(add, 0).call()
    silver = contract.functions.balanceOf(add, 1).call()
    if gold:
        st.write('Gold Membership confirmed. 25% off!')
        st.image('./images/pexels-pixabay-47047.jpg')
    elif silver:
        st.write('Silver Membership confirmed 10% off!')
        st.image('./images/pexels-pineapple-supply-co-137092.jpg')
    else:
        st.write('No membership :(. Please buy below :D!')


if st.button('Buy Silver'):
    contract = load_contract()
    silver = contract.encodeABI('buy', [address, 1])
    st.write(f'open metamask and send this data to the contract address: {contract.address}')
    st.write(f'Data: {silver}')
    st.write(f'Don\'t forget to attach payment')
if st.button('Buy Gold'):
    contract = load_contract()
    gold = contract.encodeABI('buy', [address, 0])
    st.write(f'open metamask and send this data to the contract address: {contract.address}')
    st.write(f'Data: {gold}')
    st.write(f'Don\'t forget to attach payment')
st.markdown("---")



