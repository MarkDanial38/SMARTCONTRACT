/**********************************************************************
*These solidity codes have been obtained from Etherscan for extracting
*the smartcontract related info.
*The data will be used by MATRIX AI team as the reference basis for
*MATRIX model analysis,extraction of contract semantics,
*as well as AI based data analysis, etc.
**********************************************************************/
/*
 * @title Mixin contract which supports different payment channels and provides analytical per-channel data.
 * @author Eenae
 */
contract InvestmentAnalytics {
function iaInvestedBy(address investor) external payable;
}

/*
 * @title This is proxy for analytics. Target contract can be found at field m_analytics (see "read contract").
 * @author Eenae
 */
contract AnalyticProxy {

    function AnalyticProxy() {
        m_analytics = InvestmentAnalytics(msg.sender);
    }

    /// @notice forward payment to analytics-capable contract
    function() payable {
        m_analytics.iaInvestedBy.value(msg.value)(msg.sender);
    }

    InvestmentAnalytics public m_analytics;
}