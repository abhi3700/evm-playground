/* 
    Get function return value
*/

/* 
    Here, the interface of function `createReleaseSchedule` looks like this:
    
    ```solidity
    function createReleaseSchedule(
        uint256 releaseCount,
        uint256 delayUntilFirstReleaseInSeconds,
        uint256 initialReleasePortionInBips,
        uint256 periodBetweenReleasesInSeconds
    ) external returns (uint256 unlockScheduleId)
    ```

*/

const tx = await tokenLockup
  .connect(reserveAccount)
  .createReleaseSchedule(1, 0, 10000, 0);

const scheduleId = tx.value.toString();
