Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5AC02BA444
	for <lists+linux-s390@lfdr.de>; Fri, 20 Nov 2020 09:05:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726543AbgKTIFZ (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Fri, 20 Nov 2020 03:05:25 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:54456 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726304AbgKTIFZ (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Fri, 20 Nov 2020 03:05:25 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0AK7WZbU009346;
        Fri, 20 Nov 2020 03:05:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=RepNJH5CSL5sV8GkD6oHItGxaj05JtAv2B98/5ZikOc=;
 b=qnN5Ph+y8GIW/K+q76qQU3p8+zabAjk7Yya1XIWlQcidp3uAQPkee9TiQXuofFvvfOFt
 uGod6/2kqbLzGESboFuuKoWyik57Z0a8dBlg16n3RteUtYTV+VVAijoNM/9XzpsXdLUo
 9zzWq7fDhv15rgYtfAX450izyLs0PSayL4274u1Ay7C9pqmGWMCUIioe3Zh31SbAdNXI
 NH1gN6ML/g1Wo6mCL+2mNt+VuXJHTWLbvJ+RBvUi++sTbQcTK6J5Ab6K28O96fhLoWy6
 jVOLHNtUCAQhpJC4aOJinpFYJGFuu0HWxTN3fOBk/IfgQv3SCK66INlmGC+dECZn6Z7A fg== 
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0b-001b2d01.pphosted.com with ESMTP id 34x5u361nk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 20 Nov 2020 03:05:11 -0500
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0AK827mp010032;
        Fri, 20 Nov 2020 08:05:10 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma02fra.de.ibm.com with ESMTP id 34t6v8cfjj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 20 Nov 2020 08:05:09 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0AK857qD31523184
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 20 Nov 2020 08:05:07 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0E91011C05E;
        Fri, 20 Nov 2020 08:05:07 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 72F3A11C0CD;
        Fri, 20 Nov 2020 08:05:06 +0000 (GMT)
Received: from [9.145.74.155] (unknown [9.145.74.155])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 20 Nov 2020 08:05:06 +0000 (GMT)
Subject: Re: [PATCH v2 1/6] s390/ctcm: Avoid temporary allocation of struct
 th_header and th_sweep.
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-s390@vger.kernel.org
Cc:     Karsten Graul <kgraul@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>
References: <20201119135719.983170-1-bigeasy@linutronix.de>
 <20201119135719.983170-2-bigeasy@linutronix.de>
From:   Julian Wiedmann <jwi@linux.ibm.com>
Message-ID: <3c6b65f7-6160-f5b1-4f2e-0fe1b180c1e4@linux.ibm.com>
Date:   Fri, 20 Nov 2020 10:05:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201119135719.983170-2-bigeasy@linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-20_03:2020-11-19,2020-11-20 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=2
 impostorscore=0 priorityscore=1501 adultscore=0 mlxlogscore=999
 lowpriorityscore=0 spamscore=0 bulkscore=0 phishscore=0 clxscore=1015
 malwarescore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011200048
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 19.11.20 15:57, Sebastian Andrzej Siewior wrote:
> The size of struct th_header is 8 byte and the size of struct th_sweep
> is 16 byte. The memory for is allocated, initialized, used and
> deallocated a few lines later.
> 
> It is more efficient to avoid the allocation/free dance and assign the
> values directly to skb's data part instead of using memcpy() for it.
> 
> Avoid an allocation of struct th_sweep/th_header and use the resulting
> skb pointer instead.
> 
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
>  drivers/s390/net/ctcm_fsms.c | 15 ++++-----------
>  drivers/s390/net/ctcm_main.c | 32 +++++---------------------------
>  drivers/s390/net/ctcm_mpc.c  | 17 ++---------------
>  3 files changed, 11 insertions(+), 53 deletions(-)
> 
> diff --git a/drivers/s390/net/ctcm_fsms.c b/drivers/s390/net/ctcm_fsms.c
> index 661d2a49bce96..b341075397d94 100644
> --- a/drivers/s390/net/ctcm_fsms.c
> +++ b/drivers/s390/net/ctcm_fsms.c
> @@ -1303,12 +1303,10 @@ static void ctcmpc_chx_txdone(fsm_instance *fi, int event, void *arg)
>  	/* p_header points to the last one we handled */
>  	if (p_header)
>  		p_header->pdu_flag |= PDU_LAST;	/*Say it's the last one*/
> -	header = kzalloc(TH_HEADER_LENGTH, gfp_type());
> -	if (!header) {
> -		spin_unlock(&ch->collect_lock);
> -		fsm_event(priv->mpcg->fsm, MPCG_EVENT_INOP, dev);
> -				goto done;
> -	}
> +
> +	header = skb_push(ch->trans_skb, TH_HEADER_LENGTH);
> +	memset(header, 0, TH_HEADER_LENGTH);
> +
>  	header->th_ch_flag = TH_HAS_PDU;  /* Normal data */
>  	ch->th_seq_num++;
>  	header->th_seq_num = ch->th_seq_num;
> @@ -1316,11 +1314,6 @@ static void ctcmpc_chx_txdone(fsm_instance *fi, int event, void *arg)
>  	CTCM_PR_DBGDATA("%s: ToVTAM_th_seq= %08x\n" ,
>  					__func__, ch->th_seq_num);
>  
> -	memcpy(skb_push(ch->trans_skb, TH_HEADER_LENGTH), header,
> -		TH_HEADER_LENGTH);	/* put the TH on the packet */
> -
> -	kfree(header);
> -
>  	CTCM_PR_DBGDATA("%s: trans_skb len:%04x \n",
>  		       __func__, ch->trans_skb->len);
>  	CTCM_PR_DBGDATA("%s: up-to-50 bytes of trans_skb "
> diff --git a/drivers/s390/net/ctcm_main.c b/drivers/s390/net/ctcm_main.c
> index d06809eac16d3..a3a74ebfee635 100644
> --- a/drivers/s390/net/ctcm_main.c
> +++ b/drivers/s390/net/ctcm_main.c
> @@ -623,25 +623,11 @@ static void ctcmpc_send_sweep_req(struct channel *rch)
>  				goto nomem;
>  	}
>  
> -	header = kmalloc(TH_SWEEP_LENGTH, gfp_type());
> -
> -	if (!header) {
> -		dev_kfree_skb_any(sweep_skb);
> -		/* rc = -ENOMEM; */
> -				goto nomem;
> -	}
> -
> -	header->th.th_seg	= 0x00 ;
> +	header = skb_put(sweep_skb, TH_SWEEP_LENGTH);
> +	memset(header, 0, TH_SWEEP_LENGTH);

Will squash this (and the one below) into skb_put_zero() when applying.

>  	header->th.th_ch_flag	= TH_SWEEP_REQ;  /* 0x0f */
> -	header->th.th_blk_flag	= 0x00;
> -	header->th.th_is_xid	= 0x00;
> -	header->th.th_seq_num	= 0x00;
>  	header->sw.th_last_seq	= ch->th_seq_num;
>  
> -	skb_put_data(sweep_skb, header, TH_SWEEP_LENGTH);
> -
> -	kfree(header);
> -
>  	netif_trans_update(dev);
>  	skb_queue_tail(&ch->sweep_queue, sweep_skb);
>  
> @@ -768,25 +754,17 @@ static int ctcmpc_transmit_skb(struct channel *ch, struct sk_buff *skb)
>  
>  	ch->prof.txlen += skb->len - PDU_HEADER_LENGTH;
>  
> -	header = kmalloc(TH_HEADER_LENGTH, gfp_type());
> -	if (!header)
> -		goto nomem_exit;
> +	/* put the TH on the packet */
> +	header = skb_push(skb, TH_HEADER_LENGTH);
> +	memset(header, 0, TH_HEADER_LENGTH);
>  
> -	header->th_seg = 0x00;
>  	header->th_ch_flag = TH_HAS_PDU;  /* Normal data */
> -	header->th_blk_flag = 0x00;
> -	header->th_is_xid = 0x00;          /* Just data here */
>  	ch->th_seq_num++;
>  	header->th_seq_num = ch->th_seq_num;
>  
>  	CTCM_PR_DBGDATA("%s(%s) ToVTAM_th_seq= %08x\n" ,
>  		       __func__, dev->name, ch->th_seq_num);
>  
> -	/* put the TH on the packet */
> -	memcpy(skb_push(skb, TH_HEADER_LENGTH), header, TH_HEADER_LENGTH);
> -
> -	kfree(header);
> -
>  	CTCM_PR_DBGDATA("%s(%s): skb len: %04x\n - pdu header and data for "
>  			"up to 32 bytes sent to vtam:\n",
>  				__func__, dev->name, skb->len);
> diff --git a/drivers/s390/net/ctcm_mpc.c b/drivers/s390/net/ctcm_mpc.c
> index 85a1a4533cbeb..0929ff2fd5c1a 100644
> --- a/drivers/s390/net/ctcm_mpc.c
> +++ b/drivers/s390/net/ctcm_mpc.c
> @@ -655,24 +655,11 @@ static void ctcmpc_send_sweep_resp(struct channel *rch)
>  		goto done;
>  	}
>  
> -	header = kmalloc(sizeof(struct th_sweep), gfp_type());
> -
> -	if (!header) {
> -		dev_kfree_skb_any(sweep_skb);
> -		goto done;
> -	}
> -
> -	header->th.th_seg	= 0x00 ;
> +	header = skb_put(sweep_skb, TH_SWEEP_LENGTH);
> +	memset(header, 0, TH_SWEEP_LENGTH);
>  	header->th.th_ch_flag	= TH_SWEEP_RESP;
> -	header->th.th_blk_flag	= 0x00;
> -	header->th.th_is_xid	= 0x00;
> -	header->th.th_seq_num	= 0x00;
>  	header->sw.th_last_seq	= ch->th_seq_num;
>  
> -	skb_put_data(sweep_skb, header, TH_SWEEP_LENGTH);
> -
> -	kfree(header);
> -
>  	netif_trans_update(dev);
>  	skb_queue_tail(&ch->sweep_queue, sweep_skb);
>  
> 

