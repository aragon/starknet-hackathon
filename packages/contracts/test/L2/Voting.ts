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
    let res = await contract.invoke("create_poll", { duration: 100 });
    

    const { value } = await contract.call("termination_time", {poll_id: 1});
    expect(value).to.equal(15n);
  });

});
