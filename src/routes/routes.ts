import { Request, Response } from "express";
import { ethers, providers } from "ethers";
import WalletConnectProvider from "@walletconnect/web3-provider";
require("dotenv").config();
const provider = new WalletConnectProvider({ infuraId: process.env.infuraId });

export interface RequestArguements {
  method: string;
  params?: unknown[] | object;
}
export async function mint(res: Request, resp: Response) {
  await provider.enable();
  const web3Provider = new providers.Web3Provider(provider);
  const request: RequestArguements = res.body;
  const result = await provider.request(request);
  return result;
}
