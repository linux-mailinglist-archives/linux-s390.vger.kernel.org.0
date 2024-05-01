Return-Path: <linux-s390+bounces-3752-lists+linux-s390=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ABD0F8B8610
	for <lists+linux-s390@lfdr.de>; Wed,  1 May 2024 09:24:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA0A61C20E74
	for <lists+linux-s390@lfdr.de>; Wed,  1 May 2024 07:24:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE8204C635;
	Wed,  1 May 2024 07:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QozLcbSX"
X-Original-To: linux-s390@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B31E31D6BD;
	Wed,  1 May 2024 07:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714548295; cv=none; b=BksVfoOW1Pz1kPabT8lkP+WSBE9vQ4WWXnpkGWM9lLt9sqyBBSIVnBfAHyQgO0aUnC9PiHVLBxAVCHnbRTRFps5TnopMBse5fh18824/CUa4IiHk7E+kpe07jGXSfK4ySGv4ZFdA0lYu2IBm9dXkxuK9X6SuULPpjw2/1hZcMHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714548295; c=relaxed/simple;
	bh=7mroVcXyzjn88rBeQBktn1kW0XEboIPwl5PzfXxtCuA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vj2huVje1JoJhSFUHfOnkoGjF8w+Bj8szeuCJg11rU0cNVOXz71ILTFMvYcv8ZE4tY1x9kwoetR7X7VDGp/kkBRKnVwnvPIdnNtqa2Jq5hWdSNbNUkFS5wZpq7ANQpUPC6yG7un3hSZnluxtsXR2tAKoNSYNv0KKvjnrdHq4Xjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QozLcbSX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50C99C113CC;
	Wed,  1 May 2024 07:24:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714548295;
	bh=7mroVcXyzjn88rBeQBktn1kW0XEboIPwl5PzfXxtCuA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QozLcbSXMZ4rGwOaJKShvaFmnm0VCu/a36ZKLT9sBA3LLMRwP/VCZMLnWltGQGhRJ
	 AEP996IVFNp7qjL40ZrVKfXIsuCNXIrJc9ql+sPx31vln7eEHlLKlG188tAbvk0y94
	 ExDVKcaGFz0srp8xYeGCnb7S/wzt+IC9b4WKGW4Z8O1NVonIhu1l4NNRIuyVf//PiQ
	 mgjayxrcmMzzsFW7zsg3Cf3vMkM0RRpJaj09cpIl597rj+0D7prTnnoXbQK7ZKuLzd
	 M6D0L41SmhfZgURoCXGIG4thEpxb9BKEykJUp6El/lkvr67e/6vfcJgb+ls1ExH34c
	 JjpgylRqgdPIA==
Date: Wed, 1 May 2024 08:24:49 +0100
From: Simon Horman <horms@kernel.org>
To: Alexandra Winter <wintera@linux.ibm.com>
Cc: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
	netdev@vger.kernel.org, linux-s390@vger.kernel.org,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Thorsten Winkler <twinkler@linux.ibm.com>,
	Wenjia Zhang <wenjia@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>
Subject: Re: [PATCH net] s390/qeth: Fix kernel panic after setting hsuid
Message-ID: <20240501072449.GH2575892@kernel.org>
References: <20240430091004.2265683-1-wintera@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240430091004.2265683-1-wintera@linux.ibm.com>

+ Wenjia, Christian, Sven

[ I am not trimming this email in order to leave the full
  context for those added to the CC list.
  All I have added below is my own Reviewed-by tag. ]

On Tue, Apr 30, 2024 at 11:10:04AM +0200, Alexandra Winter wrote:
> Symptom:
> When the hsuid attribute is set for the first time on an IQD Layer3
> device while the corresponding network interface is already UP,
> the kernel will try to execute a napi function pointer that is NULL.
> 
> Example:
> ---------------------------------------------------------------------------
> [ 2057.572696] illegal operation: 0001 ilc:1 [#1] SMP
> [ 2057.572702] Modules linked in: af_iucv qeth_l3 zfcp scsi_transport_fc sunrpc nft_fib_inet nft_fib_ipv4 nft_fib_ipv6 nft_fib nft_reject_inet nf_reject_ipv4 nf_reject_ipv6
> nft_reject nft_ct nf_tables_set nft_chain_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 ip_set nf_tables libcrc32c nfnetlink ghash_s390 prng xts aes_s390 des_s390 de
> s_generic sha3_512_s390 sha3_256_s390 sha512_s390 vfio_ccw vfio_mdev mdev vfio_iommu_type1 eadm_sch vfio ext4 mbcache jbd2 qeth_l2 bridge stp llc dasd_eckd_mod qeth dasd_mod
>  qdio ccwgroup pkey zcrypt
> [ 2057.572739] CPU: 6 PID: 60182 Comm: stress_client Kdump: loaded Not tainted 4.18.0-541.el8.s390x #1
> [ 2057.572742] Hardware name: IBM 3931 A01 704 (LPAR)
> [ 2057.572744] Krnl PSW : 0704f00180000000 0000000000000002 (0x2)
> [ 2057.572748]            R:0 T:1 IO:1 EX:1 Key:0 M:1 W:0 P:0 AS:3 CC:3 PM:0 RI:0 EA:3
> [ 2057.572751] Krnl GPRS: 0000000000000004 0000000000000000 00000000a3b008d8 0000000000000000
> [ 2057.572754]            00000000a3b008d8 cb923a29c779abc5 0000000000000000 00000000814cfd80
> [ 2057.572756]            000000000000012c 0000000000000000 00000000a3b008d8 00000000a3b008d8
> [ 2057.572758]            00000000bab6d500 00000000814cfd80 0000000091317e46 00000000814cfc68
> [ 2057.572762] Krnl Code:#0000000000000000: 0000                illegal
>                          >0000000000000002: 0000                illegal
>                           0000000000000004: 0000                illegal
>                           0000000000000006: 0000                illegal
>                           0000000000000008: 0000                illegal
>                           000000000000000a: 0000                illegal
>                           000000000000000c: 0000                illegal
>                           000000000000000e: 0000                illegal
> [ 2057.572800] Call Trace:
> [ 2057.572801] ([<00000000ec639700>] 0xec639700)
> [ 2057.572803]  [<00000000913183e2>] net_rx_action+0x2ba/0x398
> [ 2057.572809]  [<0000000091515f76>] __do_softirq+0x11e/0x3a0
> [ 2057.572813]  [<0000000090ce160c>] do_softirq_own_stack+0x3c/0x58
> [ 2057.572817] ([<0000000090d2cbd6>] do_softirq.part.1+0x56/0x60)
> [ 2057.572822]  [<0000000090d2cc60>] __local_bh_enable_ip+0x80/0x98
> [ 2057.572825]  [<0000000091314706>] __dev_queue_xmit+0x2be/0xd70
> [ 2057.572827]  [<000003ff803dd6d6>] afiucv_hs_send+0x24e/0x300 [af_iucv]
> [ 2057.572830]  [<000003ff803dd88a>] iucv_send_ctrl+0x102/0x138 [af_iucv]
> [ 2057.572833]  [<000003ff803de72a>] iucv_sock_connect+0x37a/0x468 [af_iucv]
> [ 2057.572835]  [<00000000912e7e90>] __sys_connect+0xa0/0xd8
> [ 2057.572839]  [<00000000912e9580>] sys_socketcall+0x228/0x348
> [ 2057.572841]  [<0000000091514e1a>] system_call+0x2a6/0x2c8
> [ 2057.572843] Last Breaking-Event-Address:
> [ 2057.572844]  [<0000000091317e44>] __napi_poll+0x4c/0x1d8
> [ 2057.572846]
> [ 2057.572847] Kernel panic - not syncing: Fatal exception in interrupt
> -------------------------------------------------------------------------------------------
> 
> Analysis:
> There is one napi structure per out_q: card->qdio.out_qs[i].napi
> The napi.poll functions are set during qeth_open().
> 
> Since
> commit 1cfef80d4c2b ("s390/qeth: Don't call dev_close/dev_open (DOWN/UP)")
> qeth_set_offline()/qeth_set_online() no longer call dev_close()/
> dev_open(). So if qeth_free_qdio_queues() cleared
> card->qdio.out_qs[i].napi.poll while the network interface was UP and the
> card was offline, they are not set again.
> 
> Reproduction:
> chzdev -e $devno layer2=0
> ip link set dev $network_interface up
> echo 0 > /sys/bus/ccwgroup/devices/0.0.$devno/online
> echo foo > /sys/bus/ccwgroup/devices/0.0.$devno/hsuid
> echo 1 > /sys/bus/ccwgroup/devices/0.0.$devno/online
> -> Crash (can be enforced e.g. by af_iucv connect(), ip link down/up, ...)
> 
> Note that a Completion Queue (CQ) is only enabled or disabled, when hsuid
> is set for the first time or when it is removed.
> 
> Workarounds:
> - Set hsuid before setting the device online for the first time
> or
> - Use chzdev -d $devno; chzdev $devno hsuid=xxx; chzdev -e $devno;
> to set hsuid on an existing device. (this will remove and recreate the
> network interface)
> 
> Fix:
> There is no need to free the output queues when a completion queue is
> added or removed.
> card->qdio.state now indicates whether the inbound buffer pool and the
> outbound queues are allocated.
> card->qdio.c_q indicates whether a CQ is allocated.
> 
> Fixes: 1cfef80d4c2b ("s390/qeth: Don't call dev_close/dev_open (DOWN/UP)")
> Signed-off-by: Alexandra Winter <wintera@linux.ibm.com>

Reviewed-by: Simon Horman <horms@kernel.org>

> ---
>  drivers/s390/net/qeth_core_main.c | 61 ++++++++++++++-----------------
>  1 file changed, 27 insertions(+), 34 deletions(-)
> 
> diff --git a/drivers/s390/net/qeth_core_main.c b/drivers/s390/net/qeth_core_main.c
> index f0b8b709649f..a3adaec5504e 100644
> --- a/drivers/s390/net/qeth_core_main.c
> +++ b/drivers/s390/net/qeth_core_main.c
> @@ -364,30 +364,33 @@ static int qeth_cq_init(struct qeth_card *card)
>  	return rc;
>  }
>  
> +static void qeth_free_cq(struct qeth_card *card)
> +{
> +	if (card->qdio.c_q) {
> +		qeth_free_qdio_queue(card->qdio.c_q);
> +		card->qdio.c_q = NULL;
> +	}
> +}
> +
>  static int qeth_alloc_cq(struct qeth_card *card)
>  {
>  	if (card->options.cq == QETH_CQ_ENABLED) {
>  		QETH_CARD_TEXT(card, 2, "cqon");
> -		card->qdio.c_q = qeth_alloc_qdio_queue();
>  		if (!card->qdio.c_q) {
> -			dev_err(&card->gdev->dev, "Failed to create completion queue\n");
> -			return -ENOMEM;
> +			card->qdio.c_q = qeth_alloc_qdio_queue();
> +			if (!card->qdio.c_q) {
> +				dev_err(&card->gdev->dev,
> +					"Failed to create completion queue\n");
> +				return -ENOMEM;
> +			}
>  		}
>  	} else {
>  		QETH_CARD_TEXT(card, 2, "nocq");
> -		card->qdio.c_q = NULL;
> +		qeth_free_cq(card);
>  	}
>  	return 0;
>  }
>  
> -static void qeth_free_cq(struct qeth_card *card)
> -{
> -	if (card->qdio.c_q) {
> -		qeth_free_qdio_queue(card->qdio.c_q);
> -		card->qdio.c_q = NULL;
> -	}
> -}
> -
>  static enum iucv_tx_notify qeth_compute_cq_notification(int sbalf15,
>  							int delayed)
>  {
> @@ -2628,6 +2631,10 @@ static int qeth_alloc_qdio_queues(struct qeth_card *card)
>  
>  	QETH_CARD_TEXT(card, 2, "allcqdbf");
>  
> +	/* completion */
> +	if (qeth_alloc_cq(card))
> +		goto out_err;
> +
>  	if (atomic_cmpxchg(&card->qdio.state, QETH_QDIO_UNINITIALIZED,
>  		QETH_QDIO_ALLOCATED) != QETH_QDIO_UNINITIALIZED)
>  		return 0;
> @@ -2663,10 +2670,6 @@ static int qeth_alloc_qdio_queues(struct qeth_card *card)
>  		queue->priority = QETH_QIB_PQUE_PRIO_DEFAULT;
>  	}
>  
> -	/* completion */
> -	if (qeth_alloc_cq(card))
> -		goto out_freeoutq;
> -
>  	return 0;
>  
>  out_freeoutq:
> @@ -2677,6 +2680,8 @@ static int qeth_alloc_qdio_queues(struct qeth_card *card)
>  	qeth_free_buffer_pool(card);
>  out_buffer_pool:
>  	atomic_set(&card->qdio.state, QETH_QDIO_UNINITIALIZED);
> +	qeth_free_cq(card);
> +out_err:
>  	return -ENOMEM;
>  }
>  
> @@ -2684,11 +2689,12 @@ static void qeth_free_qdio_queues(struct qeth_card *card)
>  {
>  	int i, j;
>  
> +	qeth_free_cq(card);
> +
>  	if (atomic_xchg(&card->qdio.state, QETH_QDIO_UNINITIALIZED) ==
>  		QETH_QDIO_UNINITIALIZED)
>  		return;
>  
> -	qeth_free_cq(card);
>  	for (j = 0; j < QDIO_MAX_BUFFERS_PER_Q; ++j) {
>  		if (card->qdio.in_q->bufs[j].rx_skb) {
>  			consume_skb(card->qdio.in_q->bufs[j].rx_skb);
> @@ -3742,24 +3748,11 @@ static void qeth_qdio_poll(struct ccw_device *cdev, unsigned long card_ptr)
>  
>  int qeth_configure_cq(struct qeth_card *card, enum qeth_cq cq)
>  {
> -	int rc;
> -
> -	if (card->options.cq ==  QETH_CQ_NOTAVAILABLE) {
> -		rc = -1;
> -		goto out;
> -	} else {
> -		if (card->options.cq == cq) {
> -			rc = 0;
> -			goto out;
> -		}
> -
> -		qeth_free_qdio_queues(card);
> -		card->options.cq = cq;
> -		rc = 0;
> -	}
> -out:
> -	return rc;
> +	if (card->options.cq == QETH_CQ_NOTAVAILABLE)
> +		return -1;
>  
> +	card->options.cq = cq;
> +	return 0;
>  }
>  EXPORT_SYMBOL_GPL(qeth_configure_cq);
>  
> -- 
> 2.40.1
> 
> 

