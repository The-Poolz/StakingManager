// SPDX-License-Identifier: MIT
pragma solidity ^0.8.29;

import "@openzeppelin/contracts/interfaces/IERC4626.sol";
import "@openzeppelin/contracts/interfaces/IERC20.sol";

interface IStakingManager {
    /// @notice Emitted when a user stakes assets.
    event Stake(address indexed user, uint256 assets, uint256 shares);

    /// @notice Emitted when a user unstakes their shares.
    event Unstake(address indexed user, uint256 shares, uint256 assets);

    /// @notice Emitted when the staking vault is set.
    event StakingVaultSet(IERC4626 stakingVault, IERC20 token);

    /// @notice Emitted when fees are collected during staking.
    event InputFeeCollected(uint256 feeAmount);

    /// @notice Emitted when fees are collected during unstaking.
    event OutputFeeCollected(uint256 feeAmount);

    /// @notice Emitted when the input fee rate is updated.
    event InputFeeRateUpdated(uint256 oldFeeRate, uint256 newFeeRate);

    /// @notice Emitted when the output fee rate is updated.
    event OutputFeeRateUpdated(uint256 oldFeeRate, uint256 newFeeRate);

    /// @notice Emitted when fees are withdrawn.
    event FeesWithdrawn(address indexed recipient, uint256 amount);

    /**
     * @notice Stake assets in the vault.
     * @param assets The amount of assets to stake.
     */
    function stake(uint256 assets) external;

    /**
     * @notice Unstake shares and receive the underlying assets.
     * @param shares The number of shares to unstake.
     */
    function unstake(uint256 shares) external;

    /**
     * @notice Set the input fee rate for staking operations.
     * @param _inputFeeRate The new input fee rate in basis points.
     */
    function setInputFeeRate(uint256 _inputFeeRate) external;

    /**
     * @notice Set the output fee rate for unstaking operations.
     * @param _outputFeeRate The new output fee rate in basis points.
     */
    function setOutputFeeRate(uint256 _outputFeeRate) external;

    /**
     * @notice Withdraw accumulated fees.
     * @param recipient The address to receive the fees.
     */
    function withdrawFees(address recipient) external;

    /// @notice Error thrown when attempting to stake or unstake zero assets or shares.
    error AmountMustBeGreaterThanZero();

    /// @notice Error thrown when the user doesn't have enough shares to unstake.
    error InsufficientShares();

    /// @notice Error thrown when setting a zero address for the vault or token.
    error ZeroAddress();

    /// @notice Error thrown when setting an invalid fee rate.
    error InvalidFeeRate();

    /// @notice Error thrown when there are no fees to withdraw.
    error NoFeesToWithdraw();
}
