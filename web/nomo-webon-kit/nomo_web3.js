import {
  invokeNomoFunction,
  invokeNomoFunctionCached,
  isFallbackModeActive,
} from "./dart_interface.js";
import { nomoAuthFetch } from "./nomo_auth.js";
import { nomoInstallWebOn } from "./nomo_multi_webons.js";
/**
 * Creates a signature for an EVM-based transaction.
 * See EthersjsNomoSigner for an example on how to use this function.
 *
 * Needs nomo.permission.SIGN_EVM_TRANSACTION.
 */
export async function nomoSignEvmTransaction(args) {
  // a fallback mode is implemented in EthersjsNomoSigner
  return await invokeNomoFunction("nomoSignEvmTransaction", args);
}
/**
 * Creates an Ethereum-styled message signature.
 * The resulting signature is not usable for submitting transactions,
 * but it can be used as a proof that the user controls a wallet.
 *
 * Needs nomo.permission.SIGN_EVM_MESSAGE.
 */
export async function nomoSignEvmMessage(args) {
  if (isFallbackModeActive()) {
    return {
      sigHex:
        "0x1e8fccc1f75eda4ee82adb9b3b0ae8243b418bd8810873b6df696d240267a223105e265189bd2ea0677bfa42f5d9cbba50622d91ef4e4805cd81f9f8715e38101b",
    };
  }
  return await invokeNomoFunction("nomoSignEvmMessage", args);
}
/**
 * Opens a confirmation-dialog to send assets away from the Nomo App.
 * Assets are only sent if the user confirms the dialog.
 * "amount" should be a string that can be parsed by "BigInt.parse":  https://api.flutter.dev/flutter/dart-core/BigInt/parse.html
 *
 * Needs nomo.permission.SEND_ASSETS.
 */
export async function nomoSendAssets(args) {
  const legacyArgs = Object.assign(Object.assign({}, args), {
    assetSymbol: args.asset.symbol,
  });
  return await invokeNomoFunction("nomoSendAssets", legacyArgs);
}
/**
 * Opens a dialog for the user to select an asset.
 * If the dialog does not look "correct", WebOns are free to call "nomoGetVisibleAssets" and implement their own dialog.
 */
export async function nomoSelectAssetFromDialog() {
  if (isFallbackModeActive()) {
    return {
      selectedAsset: {
        name: "AVINOC",
        symbol: "AVINOC ZEN20",
        decimals: 18,
        balance: "1000000000000000000",
        contractAddress: "0xF1cA9cb74685755965c7458528A36934Df52A3EF",
        receiveAddress: "0xF1cA9cb74685755965c7458528A36934Df52A3EF",
      },
    };
  }
  return await invokeNomoFunction("nomoSelectAssetFromDialog", {});
}
/**
 * Returns a list of assets that are currently visible in the Nomo Wallet.
 */
export async function nomoGetVisibleAssets() {
  if (isFallbackModeActive()) {
    return {
      visibleAssets: [
        {
          name: "AVINOC",
          symbol: "AVINOC ZEN20",
          decimals: 18,
          contractAddress: "0xF1cA9cb74685755965c7458528A36934Df52A3EF",
        },
      ],
    };
  }
  return await invokeNomoFunction("nomoGetVisibleAssets", {});
}
/**
 * A convenience function to get the Smartchain address of the Nomo Wallet.
 * Internally, it calls "nomoGetWalletAddresses" and caches the result.
 */
export async function nomoGetEvmAddress() {
  const res = await nomoGetWalletAddresses();
  return res.walletAddresses["ETH"];
}
/**
 * Returns blockchain-addresses of the NOMO-user.
 */
export async function nomoGetWalletAddresses() {
  if (isFallbackModeActive()) {
    return {
      walletAddresses: {
        ETH: "0x18698f662cf75a539754b9aadaac0d0aeca48f2f",
        ZENIQ: "mMhxgh4HsQPzJBGChXHTTTPgVZorHTTcnu",
        BTC: "16XcNkGbmZRcLVvg1NeQ7fT9G5U65cPttR",
        LTC: "ltc1qjklfx8kln8agmfv96m9n3xrjz5daq5gj24skxa",
        EURO: "c6w63CCfYFjqVD4D8sd8Ja8b1xt9tzuoop",
        BCH: "bitcoincash:qq729gey4rh2f0jnqqndq7mm4lmmsyhuyya3wlyl2z",
      },
    };
  }
  return await invokeNomoFunctionCached("nomoGetWalletAddresses", null);
}

export async function nomoLogIntoChat(fallbackString) {
  const value = await invokeNomoFunction("nomoLogIntoChat", null);
  console.log("VALUE OF NOMOLOGIN", value);
  return value;
}
/**
 * Returns a set of URLs that contain icons of the asset.
 * May throw an error if no icons can be found.
 */
export async function nomoGetAssetIcon(args) {
  const legacyArgs = Object.assign(Object.assign({}, args), {
    assetSymbol: args.symbol,
  });
  return await invokeNomoFunction("nomoGetAssetIcon", legacyArgs);
}
/**
 * Returns an asset price.
 * Might be slow if a price is not yet in the Nomo App's cache.
 */
export async function nomoGetAssetPrice(args) {
  if (isFallbackModeActive()) {
    const baseEndpoint = "https://price.zeniq.services/v2/currentprice";
    const priceEndpoint =
      !!args.contractAddress && !!args.network
        ? `${baseEndpoint}/${args.contractAddress}/USD/${args.network}`
        : `${baseEndpoint}/${args.name}/USD`;
    const res = await nomoAuthFetch({ url: priceEndpoint });
    const price = JSON.parse(res.response).price;
    return {
      price,
      currencyDisplayName: "US Dollar",
      currencySymbol: "$",
    };
  }
  return await invokeNomoFunction("nomoGetAssetPrice", args);
}
/**
 * Returns not only the balance of an asset, but also additional information like the network, a contract-address and a receive-address.
 * Typically, the decimals are needed to convert a raw balance into a user-readable balance.
 */
export async function nomoGetBalance(args) {
  const legacyArgs = Object.assign(Object.assign({}, args), {
    assetSymbol: args.symbol,
  });
  return await invokeNomoFunction("nomoGetBalance", legacyArgs);
}
/**
 * Adds a custom token to the list of visible assets in the Nomo Wallet.
 * Before that, it opens a dialog for the user to confirm.
 *
 * Needs nomo.permission.ADD_CUSTOM_TOKEN.
 */
export async function nomoAddCustomToken(args) {
  return await invokeNomoFunction("nomoAddCustomToken", args);
}
/**
 * Launches a free faucet that can be used for paying transaction fees.
 */
export async function nomoLaunchSmartchainFaucet() {
  return await nomoInstallWebOn({
    deeplink: "https://nomo.app/webon/faucet.nomo.app",
    skipPermissionDialog: true,
    navigateBack: false,
  });
}
/**
 * If true, then the user has made a backup of their 12 words (at some point in the past).
 * If false, then there exists no backup and the 12 words will get lost with a high probability.
 */
export async function nomoMnemonicBackupExisted() {
  if (isFallbackModeActive()) {
    return { mnemonicBackupExisted: false };
  }
  return await invokeNomoFunction("nomoMnemonicBackupExisted", {});
}
/**
 * Returns a list of NFTs that are owned by the user.
 * Can be slow if the NFTs are not yet in the Nomo App's cache.
 */
export async function nomoGetNFTs(args) {
  return await invokeNomoFunction("nomoGetNFTs", args);
}

window.nomoGetEvmAddress = nomoGetEvmAddress;
window.nomoSignEvmMessage = nomoSignEvmMessage;
window.nomoLogIntoChat = nomoLogIntoChat;
window.nomoGetWalletAddresses = nomoGetWalletAddresses;
window.nomoSelectAssetFromDialog = nomoSelectAssetFromDialog;
window.nomoGetAssetPrice = nomoGetAssetPrice