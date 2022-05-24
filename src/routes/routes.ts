import { Request, Response } from "express";
import { ethers, providers } from "ethers";
import WalletConnectProvider from "@walletconnect/web3-provider";
require("dotenv").config();
// const provider = new WalletConnectProvider({ infuraId: process.env.infuraId });

const abi = [{}];
const nftMintContract = "";
export interface RequestArguements {
  method: string;
  params?: unknown[] | object;
  chainId: number;
  mintAddress: string;
}
export async function mint(req: Request, resp: Response) {
  //FIXME verify mintaddress is checksum
  const request = req.body;
  const { chainId, mintAddress } = request;
  const provider = new ethers.providers.InfuraProvider(
    chainId,
    process.env.infuraId
  );
  //todo create contract instance and mint to address provided

  const contract = new ethers.Contract(nftMintContract, abi, provider);
  const res = contract.mint(mintAddress);
  resp.send(res);
}
