Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A9055A9338
	for <lists+linux-s390@lfdr.de>; Thu,  1 Sep 2022 11:33:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233657AbiIAJdp (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Thu, 1 Sep 2022 05:33:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234102AbiIAJdm (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 1 Sep 2022 05:33:42 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AACB133F24;
        Thu,  1 Sep 2022 02:33:38 -0700 (PDT)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2819DHHd020989;
        Thu, 1 Sep 2022 09:33:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=M2lvvbaxGtrRwV0nVm9wGyPf2AUEdYar+2aCIoLbIhc=;
 b=fPxkMo6Ms4swS6PDwwg1gtaBil89aiedwN2IdOw5sUybIwUJtk31jlv8aFfMz/yJDQAM
 abdow1H8NsfySW2AcTdzPWPa3rJTbnDeJAPuskt2LrcNo6B6F9oGsw6VtFAPs06bCDAs
 t3hfOd8nkgIVTg9TnmrvgP2fxB+ZcWw0e/vm/2yF+4G8g/GyWyct5sRQq1RTBc1uccnU
 kNUeoWIJCVfG+pontfxotHNLJxEjw+0JzBXssKs3D7EaG36eM+s6x3Ok7bh9vCce18nC
 MufYUvxNSC32/i3rZvFWaM5MwnbRo490pGdnNA/psg+bK3tbpepN2BYmXdUpAv0BYYSM XQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3jaswjgkhh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 01 Sep 2022 09:33:29 +0000
Received: from m0098419.ppops.net (m0098419.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2819FCAi028356;
        Thu, 1 Sep 2022 09:33:28 GMT
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com [169.53.41.122])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3jaswjgkg0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 01 Sep 2022 09:33:27 +0000
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
        by ppma04dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2819LI2d005359;
        Thu, 1 Sep 2022 09:33:25 GMT
Received: from b03cxnp07029.gho.boulder.ibm.com (b03cxnp07029.gho.boulder.ibm.com [9.17.130.16])
        by ppma04dal.us.ibm.com with ESMTP id 3j7awa8d5q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 01 Sep 2022 09:33:25 +0000
Received: from b03ledav001.gho.boulder.ibm.com (b03ledav001.gho.boulder.ibm.com [9.17.130.232])
        by b03cxnp07029.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2819XNtF66388264
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 1 Sep 2022 09:33:23 GMT
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8ADFC6E04E;
        Thu,  1 Sep 2022 09:33:23 +0000 (GMT)
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8C1476E052;
        Thu,  1 Sep 2022 09:33:21 +0000 (GMT)
Received: from [9.211.148.222] (unknown [9.211.148.222])
        by b03ledav001.gho.boulder.ibm.com (Postfix) with ESMTP;
        Thu,  1 Sep 2022 09:33:21 +0000 (GMT)
Message-ID: <04dbfe8a-a023-c6cf-8d20-965859c1d33a@linux.ibm.com>
Date:   Thu, 1 Sep 2022 11:33:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.13.0
Subject: Re: [PATCH net v4] net/smc: Fix possible access to freed memory in
 link clear
To:     liuyacan@corp.netease.com, tonylu@linux.alibaba.com
Cc:     davem@davemloft.net, edumazet@google.com, kgraul@linux.ibm.com,
        kuba@kernel.org, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org, netdev@vger.kernel.org,
        ubraun@linux.vnet.ibm.com, pabeni@redhat.com, wintera@linux.ibm.com
References: <Yw4bgV6c0LQ6reMc@TonyMac-Alibaba>
 <20220831155303.1758868-1-liuyacan@corp.netease.com>
From:   Wenjia Zhang <wenjia@linux.ibm.com>
In-Reply-To: <20220831155303.1758868-1-liuyacan@corp.netease.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: j26EjplNWI673IvrRWws-T0MYi4O50Nw
X-Proofpoint-ORIG-GUID: oCJWhZMQ48iPuglpVMhkpMpxvXeUWt8X
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-09-01_06,2022-08-31_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 impostorscore=0
 bulkscore=0 lowpriorityscore=0 spamscore=0 priorityscore=1501 mlxscore=0
 suspectscore=0 adultscore=0 mlxlogscore=999 clxscore=1015 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2209010042
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org



On 31.08.22 17:53, liuyacan@corp.netease.com wrote:
> From: Yacan Liu <liuyacan@corp.netease.com>
> 
> After modifying the QP to the Error state, all RX WR would be completed
> with WC in IB_WC_WR_FLUSH_ERR status. Current implementation does not
> wait for it is done, but destroy the QP and free the link group directly.
> So there is a risk that accessing the freed memory in tasklet context.
> 
> Here is a crash example:
> 
>   BUG: unable to handle page fault for address: ffffffff8f220860
>   #PF: supervisor write access in kernel mode
>   #PF: error_code(0x0002) - not-present page
>   PGD f7300e067 P4D f7300e067 PUD f7300f063 PMD 8c4e45063 PTE 800ffff08c9df060
>   Oops: 0002 [#1] SMP PTI
>   CPU: 1 PID: 0 Comm: swapper/1 Kdump: loaded Tainted: G S         OE     5.10.0-0607+ #23
>   Hardware name: Inspur NF5280M4/YZMB-00689-101, BIOS 4.1.20 07/09/2018
>   RIP: 0010:native_queued_spin_lock_slowpath+0x176/0x1b0
>   Code: f3 90 48 8b 32 48 85 f6 74 f6 eb d5 c1 ee 12 83 e0 03 83 ee 01 48 c1 e0 05 48 63 f6 48 05 00 c8 02 00 48 03 04 f5 00 09 98 8e <48> 89 10 8b 42 08 85 c0 75 09 f3 90 8b 42 08 85 c0 74 f7 48 8b 32
>   RSP: 0018:ffffb3b6c001ebd8 EFLAGS: 00010086
>   RAX: ffffffff8f220860 RBX: 0000000000000246 RCX: 0000000000080000
>   RDX: ffff91db1f86c800 RSI: 000000000000173c RDI: ffff91db62bace00
>   RBP: ffff91db62bacc00 R08: 0000000000000000 R09: c00000010000028b
>   R10: 0000000000055198 R11: ffffb3b6c001ea58 R12: ffff91db80e05010
>   R13: 000000000000000a R14: 0000000000000006 R15: 0000000000000040
>   FS:  0000000000000000(0000) GS:ffff91db1f840000(0000) knlGS:0000000000000000
>   CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>   CR2: ffffffff8f220860 CR3: 00000001f9580004 CR4: 00000000003706e0
>   DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>   DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>   Call Trace:
>    <IRQ>
>    _raw_spin_lock_irqsave+0x30/0x40
>    mlx5_ib_poll_cq+0x4c/0xc50 [mlx5_ib]
>    smc_wr_rx_tasklet_fn+0x56/0xa0 [smc]
>    tasklet_action_common.isra.21+0x66/0x100
>    __do_softirq+0xd5/0x29c
>    asm_call_irq_on_stack+0x12/0x20
>    </IRQ>
>    do_softirq_own_stack+0x37/0x40
>    irq_exit_rcu+0x9d/0xa0
>    sysvec_call_function_single+0x34/0x80
>    asm_sysvec_call_function_single+0x12/0x20
> 
> Fixes: bd4ad57718cc ("smc: initialize IB transport incl. PD, MR, QP, CQ, event, WR")
> Signed-off-by: Yacan Liu <liuyacan@corp.netease.com>
> 
> ---
> Chagen in v4:
>    -- Remove the rx_drain flag because smc_wr_rx_post() may not have been called.
>    -- Remove timeout.
> Change in v3:
>    -- Tune commit message (Signed-Off tag, Fixes tag).
>       Tune code to avoid column length exceeding.
> Change in v2:
>    -- Fix some compile warnings and errors.
> ---
>   net/smc/smc_core.c | 2 ++
>   net/smc/smc_core.h | 2 ++
>   net/smc/smc_wr.c   | 9 +++++++++
>   net/smc/smc_wr.h   | 1 +
>   4 files changed, 14 insertions(+)
> 
> diff --git a/net/smc/smc_core.c b/net/smc/smc_core.c
> index ff49a11f5..f92a916e9 100644
> --- a/net/smc/smc_core.c
> +++ b/net/smc/smc_core.c
> @@ -757,6 +757,7 @@ int smcr_link_init(struct smc_link_group *lgr, struct smc_link *lnk,
>   	lnk->lgr = lgr;
>   	smc_lgr_hold(lgr); /* lgr_put in smcr_link_clear() */
>   	lnk->link_idx = link_idx;
> +	lnk->wr_rx_id_compl = 0;
>   	smc_ibdev_cnt_inc(lnk);
>   	smcr_copy_dev_info_to_link(lnk);
>   	atomic_set(&lnk->conn_cnt, 0);
> @@ -1269,6 +1270,7 @@ void smcr_link_clear(struct smc_link *lnk, bool log)
>   	smcr_buf_unmap_lgr(lnk);
>   	smcr_rtoken_clear_link(lnk);
>   	smc_ib_modify_qp_error(lnk);
> +	smc_wr_drain_cq(lnk);
>   	smc_wr_free_link(lnk);
>   	smc_ib_destroy_queue_pair(lnk);
>   	smc_ib_dealloc_protection_domain(lnk);
> diff --git a/net/smc/smc_core.h b/net/smc/smc_core.h
> index fe8b524ad..285f9bd8e 100644
> --- a/net/smc/smc_core.h
> +++ b/net/smc/smc_core.h
> @@ -115,8 +115,10 @@ struct smc_link {
>   	dma_addr_t		wr_rx_dma_addr;	/* DMA address of wr_rx_bufs */
>   	dma_addr_t		wr_rx_v2_dma_addr; /* DMA address of v2 rx buf*/
>   	u64			wr_rx_id;	/* seq # of last recv WR */
> +	u64			wr_rx_id_compl; /* seq # of last completed WR */
>   	u32			wr_rx_cnt;	/* number of WR recv buffers */
>   	unsigned long		wr_rx_tstamp;	/* jiffies when last buf rx */
> +	wait_queue_head_t       wr_rx_empty_wait; /* wait for RQ empty */
>   
>   	struct ib_reg_wr	wr_reg;		/* WR register memory region */
>   	wait_queue_head_t	wr_reg_wait;	/* wait for wr_reg result */
> diff --git a/net/smc/smc_wr.c b/net/smc/smc_wr.c
> index 26f8f240d..bc8793803 100644
> --- a/net/smc/smc_wr.c
> +++ b/net/smc/smc_wr.c
> @@ -454,6 +454,7 @@ static inline void smc_wr_rx_process_cqes(struct ib_wc wc[], int num)
>   
>   	for (i = 0; i < num; i++) {
>   		link = wc[i].qp->qp_context;
> +		link->wr_rx_id_compl = wc[i].wr_id;
>   		if (wc[i].status == IB_WC_SUCCESS) {
>   			link->wr_rx_tstamp = jiffies;
>   			smc_wr_rx_demultiplex(&wc[i]);
> @@ -465,6 +466,8 @@ static inline void smc_wr_rx_process_cqes(struct ib_wc wc[], int num)
>   			case IB_WC_RNR_RETRY_EXC_ERR:
>   			case IB_WC_WR_FLUSH_ERR:
>   				smcr_link_down_cond_sched(link);
> +				if (link->wr_rx_id_compl == link->wr_rx_id)
> +					wake_up(&link->wr_rx_empty_wait);
>   				break;
>   			default:
>   				smc_wr_rx_post(link); /* refill WR RX */
> @@ -631,6 +634,11 @@ static void smc_wr_init_sge(struct smc_link *lnk)
>   	lnk->wr_reg.access = IB_ACCESS_LOCAL_WRITE | IB_ACCESS_REMOTE_WRITE;
>   }
>   
> +void smc_wr_drain_cq(struct smc_link *lnk)
> +{
> +	wait_event(lnk->wr_rx_empty_wait, lnk->wr_rx_id_compl == lnk->wr_rx_id);
> +}
> +
>   void smc_wr_free_link(struct smc_link *lnk)
>   {
>   	struct ib_device *ibdev;
> @@ -889,6 +897,7 @@ int smc_wr_create_link(struct smc_link *lnk)
>   	atomic_set(&lnk->wr_tx_refcnt, 0);
>   	init_waitqueue_head(&lnk->wr_reg_wait);
>   	atomic_set(&lnk->wr_reg_refcnt, 0);
> +	init_waitqueue_head(&lnk->wr_rx_empty_wait);
>   	return rc;
>   
>   dma_unmap:
> diff --git a/net/smc/smc_wr.h b/net/smc/smc_wr.h
> index a54e90a11..5ca5086ae 100644
> --- a/net/smc/smc_wr.h
> +++ b/net/smc/smc_wr.h
> @@ -101,6 +101,7 @@ static inline int smc_wr_rx_post(struct smc_link *link)
>   int smc_wr_create_link(struct smc_link *lnk);
>   int smc_wr_alloc_link_mem(struct smc_link *lnk);
>   int smc_wr_alloc_lgr_mem(struct smc_link_group *lgr);
> +void smc_wr_drain_cq(struct smc_link *lnk);
>   void smc_wr_free_link(struct smc_link *lnk);
>   void smc_wr_free_link_mem(struct smc_link *lnk);
>   void smc_wr_free_lgr_mem(struct smc_link_group *lgr);

Thank you @Yacan for the effort to improve our code! And Thank you @Tony 
for such valuable suggestions and testing!
I like the modification of this version. However, this is not a fix 
patch to upstream, since the patches "[PATCH net-next v2 00/10] optimize 
the parallelism of SMC-R connections" are still not applied. My 
sugguestions:
- Please talk to the author (D. Wythe <alibuda@linux.alibaba.com>) of 
those patches I mentioned above, and ask if he can take your patch as a 
part of the patch serie
- Fix patches should go to net-next
- Please send always send your new version separately, rather than as 
reply to your previous version. That makes people confused.
