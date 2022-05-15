Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE6F85278D9
	for <lists+linux-s390@lfdr.de>; Sun, 15 May 2022 19:11:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237847AbiEORKy (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Sun, 15 May 2022 13:10:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237848AbiEORKx (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Sun, 15 May 2022 13:10:53 -0400
Received: from out199-11.us.a.mail.aliyun.com (out199-11.us.a.mail.aliyun.com [47.90.199.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89816F5;
        Sun, 15 May 2022 10:10:50 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R661e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01424;MF=tonylu@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0VDBAVZA_1652634645;
Received: from localhost(mailfrom:tonylu@linux.alibaba.com fp:SMTPD_---0VDBAVZA_1652634645)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 16 May 2022 01:10:46 +0800
Date:   Mon, 16 May 2022 01:10:44 +0800
From:   Tony Lu <tonylu@linux.alibaba.com>
To:     Guangguan Wang <guangguan.wang@linux.alibaba.com>
Cc:     kgraul@linux.ibm.com, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, leon@kernel.org,
        linux-s390@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH net-next v2 1/2] net/smc: send cdc msg inline if qp has
 sufficient inline space
Message-ID: <YoE0FDc7ivfgabzy@TonyMac-Alibaba>
Reply-To: Tony Lu <tonylu@linux.alibaba.com>
References: <20220514102739.41252-1-guangguan.wang@linux.alibaba.com>
 <20220514102739.41252-2-guangguan.wang@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220514102739.41252-2-guangguan.wang@linux.alibaba.com>
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Sat, May 14, 2022 at 06:27:38PM +0800, Guangguan Wang wrote:
> As cdc msg's length is 44B, cdc msgs can be sent inline in
> most rdma devices, which can help reducing sending latency.
> 
> In my test environment, which are 2 VMs running on the same
> physical host and whose NICs(ConnectX-4Lx) are working on
> SR-IOV mode, qperf shows 0.4us-0.7us improvement in latency.
> 
> Test command:
> server: smc_run taskset -c 1 qperf
> client: smc_run taskset -c 1 qperf <server ip> -oo \
> 		msg_size:1:2K:*2 -t 30 -vu tcp_lat
> 
> The results shown below:
> msgsize     before       after
> 1B          11.9 us      11.2 us (-0.7 us)
> 2B          11.7 us      11.2 us (-0.5 us)
> 4B          11.7 us      11.3 us (-0.4 us)
> 8B          11.6 us      11.2 us (-0.4 us)
> 16B         11.7 us      11.3 us (-0.4 us)
> 32B         11.7 us      11.3 us (-0.4 us)
> 64B         11.7 us      11.2 us (-0.5 us)
> 128B        11.6 us      11.2 us (-0.4 us)
> 256B        11.8 us      11.2 us (-0.6 us)
> 512B        11.8 us      11.4 us (-0.4 us)
> 1KB         11.9 us      11.4 us (-0.5 us)
> 2KB         12.1 us      11.5 us (-0.6 us)
> 
> Reported-by: kernel test robot <lkp@intel.com>

You don't need to add this tag, this tag represents who found the issue.
Tested-by is reasonable.

> Signed-off-by: Guangguan Wang <guangguan.wang@linux.alibaba.com>

Reviewed-by: Tony Lu <tonylu@linux.alibaba.com>

Thanks,
Tony Lu

> ---
>  net/smc/smc_ib.c | 1 +
>  net/smc/smc_wr.c | 5 ++++-
>  2 files changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/net/smc/smc_ib.c b/net/smc/smc_ib.c
> index a3e2d3b89568..dcda4165d107 100644
> --- a/net/smc/smc_ib.c
> +++ b/net/smc/smc_ib.c
> @@ -671,6 +671,7 @@ int smc_ib_create_queue_pair(struct smc_link *lnk)
>  			.max_recv_wr = SMC_WR_BUF_CNT * 3,
>  			.max_send_sge = SMC_IB_MAX_SEND_SGE,
>  			.max_recv_sge = sges_per_buf,
> +			.max_inline_data = 0,
>  		},
>  		.sq_sig_type = IB_SIGNAL_REQ_WR,
>  		.qp_type = IB_QPT_RC,
> diff --git a/net/smc/smc_wr.c b/net/smc/smc_wr.c
> index 24be1d03fef9..26f8f240d9e8 100644
> --- a/net/smc/smc_wr.c
> +++ b/net/smc/smc_wr.c
> @@ -554,10 +554,11 @@ void smc_wr_remember_qp_attr(struct smc_link *lnk)
>  static void smc_wr_init_sge(struct smc_link *lnk)
>  {
>  	int sges_per_buf = (lnk->lgr->smc_version == SMC_V2) ? 2 : 1;
> +	bool send_inline = (lnk->qp_attr.cap.max_inline_data > SMC_WR_TX_SIZE);
>  	u32 i;
>  
>  	for (i = 0; i < lnk->wr_tx_cnt; i++) {
> -		lnk->wr_tx_sges[i].addr =
> +		lnk->wr_tx_sges[i].addr = send_inline ? (uintptr_t)(&lnk->wr_tx_bufs[i]) :
>  			lnk->wr_tx_dma_addr + i * SMC_WR_BUF_SIZE;
>  		lnk->wr_tx_sges[i].length = SMC_WR_TX_SIZE;
>  		lnk->wr_tx_sges[i].lkey = lnk->roce_pd->local_dma_lkey;
> @@ -575,6 +576,8 @@ static void smc_wr_init_sge(struct smc_link *lnk)
>  		lnk->wr_tx_ibs[i].opcode = IB_WR_SEND;
>  		lnk->wr_tx_ibs[i].send_flags =
>  			IB_SEND_SIGNALED | IB_SEND_SOLICITED;
> +		if (send_inline)
> +			lnk->wr_tx_ibs[i].send_flags |= IB_SEND_INLINE;
>  		lnk->wr_tx_rdmas[i].wr_tx_rdma[0].wr.opcode = IB_WR_RDMA_WRITE;
>  		lnk->wr_tx_rdmas[i].wr_tx_rdma[1].wr.opcode = IB_WR_RDMA_WRITE;
>  		lnk->wr_tx_rdmas[i].wr_tx_rdma[0].wr.sg_list =
> -- 
> 2.24.3 (Apple Git-128)
