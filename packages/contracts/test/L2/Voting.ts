import { ethers, starknet } from "hardhat";
import { expect } from "chai";
import { StarknetContract } from "hardhat/types";

describe("Voting", function () {
  this.timeout(100_000);

  let contract: StarknetContract;

  beforeEach(async () => {
    const votingFactory = await starknet.getContractFactory("Voting");
    contract = await votingFactory.deploy();
  });

  it("can create a poll", async () => {
    await contract.invoke("create_poll", { duration: 100 });
    
    let res1 = await contract.call("termination_time", {poll_id: 1});
    expect(res1["termination_timestamp"]).to.equal(100n);

    await contract.invoke("create_poll", { duration: 5 });

    let res2 = await contract.call("termination_time", {poll_id: 2});
    expect(res2["termination_timestamp"]).to.equal(5n);
  });
});
