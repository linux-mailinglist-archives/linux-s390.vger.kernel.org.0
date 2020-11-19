Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D83B2B8CAA
	for <lists+linux-s390@lfdr.de>; Thu, 19 Nov 2020 08:58:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726235AbgKSH43 (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Thu, 19 Nov 2020 02:56:29 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:58374 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726287AbgKSH43 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 19 Nov 2020 02:56:29 -0500
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0AJ7W6fl019206;
        Thu, 19 Nov 2020 02:56:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=Zs7tDff2/v2Y6srUNDWIyhAMo6AlJg+esFAitYx+FtU=;
 b=mL29NIek7ZhtQqkYRlprtT3X8e+q5T58Hd9c4/zw6KuU15GX0i1JGimG6sHkEwt5na4m
 m3XZhT0J5wRUv+np0T+d4mNnG6rdTaBd0e9423nfs3sDDcitwU8RdIllzo5pmcLtvHrR
 tYqzu8wzUe5/zzrZyozopcVjOvdfJcwOhFDpHTSudcacvPCcp0d1eiqVxMAtE1meAkBs
 BvnRcp+j59oWSaKzar1hQKh7gHGWJaVreI09i3RZMLeomhh4r+Q8uL3ycnChZqS1DE2C
 GyN9WlvbhsPRYMLXZDalhCPgNaqZdbMZonbLze+Yf3qjvKO3yLLCAKwFVnUx5xRapN14 Hw== 
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 34wg60pmxw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 19 Nov 2020 02:56:26 -0500
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0AJ7rkEL020578;
        Thu, 19 Nov 2020 07:56:24 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma04ams.nl.ibm.com with ESMTP id 34t6v8cpa6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 19 Nov 2020 07:56:24 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0AJ7uMt15898940
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 19 Nov 2020 07:56:22 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E61CD5204E;
        Thu, 19 Nov 2020 07:56:21 +0000 (GMT)
Received: from [9.145.53.92] (unknown [9.145.53.92])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 5F1285205A;
        Thu, 19 Nov 2020 07:56:21 +0000 (GMT)
Subject: Re: [PATCH 2/6] s390/ctcm: Put struct qllc on stack.
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-s390@vger.kernel.org
Cc:     Karsten Graul <kgraul@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>
References: <20201118105317.605671-1-bigeasy@linutronix.de>
 <20201118105317.605671-3-bigeasy@linutronix.de>
From:   Julian Wiedmann <jwi@linux.ibm.com>
Message-ID: <8dd75a21-0e50-d445-9532-9a0950b884ea@linux.ibm.com>
Date:   Thu, 19 Nov 2020 09:56:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201118105317.605671-3-bigeasy@linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-19_03:2020-11-17,2020-11-19 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 malwarescore=0
 phishscore=0 impostorscore=0 suspectscore=2 adultscore=0 bulkscore=0
 mlxlogscore=999 priorityscore=1501 lowpriorityscore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011190050
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 18.11.20 12:53, Sebastian Andrzej Siewior wrote:
> The size of struct qllc is 2 byte. The memory for is allocated, initialized,
> used and deallocated a few lines later.
> 
> It is more efficient to avoid the allocation/free dance and keeping the
> variable on stack. Especially since the compiler is smart enough to not
> allocate the memory on stack but assign the values directly.
> 
> Rename `qllcptr' to `qllc' and use it on stack.
> 

Can we please shrink this down to

qllcptr = (struct qllc *) skb_put(...);
qllcptr->foo = bar;
...


> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
>  drivers/s390/net/ctcm_mpc.c | 24 ++++++------------------
>  1 file changed, 6 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/s390/net/ctcm_mpc.c b/drivers/s390/net/ctcm_mpc.c
> index 04a51cc89e74c..4ff51af44d338 100644
> --- a/drivers/s390/net/ctcm_mpc.c
> +++ b/drivers/s390/net/ctcm_mpc.c
> @@ -2049,11 +2049,10 @@ static void mpc_action_rcvd_xid7(fsm_instance *fsm, int event, void *arg)
>   */
>  static int mpc_send_qllc_discontact(struct net_device *dev)
>  {
> -	__u32	new_len	= 0;
>  	struct sk_buff   *skb;
> -	struct qllc      *qllcptr;
>  	struct ctcm_priv *priv = dev->ml_priv;
>  	struct mpc_group *grp = priv->mpcg;
> +	struct qllc	qllc;
>  
>  	CTCM_PR_DEBUG("%s: GROUP STATE: %s\n",
>  		__func__, mpcg_state_names[grp->saved_state]);
> @@ -2080,31 +2079,20 @@ static int mpc_send_qllc_discontact(struct net_device *dev)
>  	case MPCG_STATE_FLOWC:
>  	case MPCG_STATE_READY:
>  		grp->send_qllc_disc = 2;
> -		new_len = sizeof(struct qllc);
> -		qllcptr = kzalloc(new_len, gfp_type() | GFP_DMA);
> -		if (qllcptr == NULL) {
> -			CTCM_DBF_TEXT_(MPC_ERROR, CTC_DBF_ERROR,
> -				"%s(%s): qllcptr allocation error",
> -						CTCM_FUNTAIL, dev->name);
> -			return -ENOMEM;
> -		}
> -
> -		qllcptr->qllc_address = 0xcc;
> -		qllcptr->qllc_commands = 0x03;
> -
> -		skb = __dev_alloc_skb(new_len, GFP_ATOMIC);
>  
> +		skb = __dev_alloc_skb(sizeof(struct qllc), GFP_ATOMIC);
>  		if (skb == NULL) {
>  			CTCM_DBF_TEXT_(MPC_ERROR, CTC_DBF_ERROR,
>  				"%s(%s): skb allocation error",
>  						CTCM_FUNTAIL, dev->name);
>  			priv->stats.rx_dropped++;
> -			kfree(qllcptr);
>  			return -ENOMEM;
>  		}
>  
> -		skb_put_data(skb, qllcptr, new_len);
> -		kfree(qllcptr);
> +		qllc.qllc_address = 0xcc;
> +		qllc.qllc_commands = 0x03;
> +
> +		skb_put_data(skb, &qllc, sizeof(struct qllc));
>  
>  		if (skb_headroom(skb) < 4) {
>  			CTCM_DBF_TEXT_(MPC_ERROR, CTC_DBF_ERROR,
> 

