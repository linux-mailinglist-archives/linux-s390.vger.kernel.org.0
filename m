Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC23C2B8C99
	for <lists+linux-s390@lfdr.de>; Thu, 19 Nov 2020 08:55:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726224AbgKSHwy (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Thu, 19 Nov 2020 02:52:54 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:59802 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726205AbgKSHwy (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 19 Nov 2020 02:52:54 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0AJ7VudP020862;
        Thu, 19 Nov 2020 02:52:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=i8YorB3PQas7CH46IDA0+Fmt+XaZ9NxWsu2wJV7FPAk=;
 b=r6c0IL4BPwe1brGLNVSK06w5Ab48CyE4QAUqtkvKf25J0ISRHdzI1W6BgVXRYMfTjZHx
 aKeUS1yst0b5FkyVtirKHsPW3iXm0B83a1WgvKoaqsf4s5wmo4bSv5XAqXQqKTudIj6K
 /FiRKK+q4Ah/K3VFb8NVjyJq+Q8aiUSLDrIOgKaedw0KrrIlbpzGXwWEOw3Cgye4JpRO
 FYEvXHZlfo5b0LHNxNWZw4BpybEIAEXJl95UxAJ09u9RDJJcqbIIwmWj4l1wxL0A8RON
 JpHkCXVE7er8lVssAg2XfK0nlZlBpGaiDOn+omQmWxfuwvFzqdhl8U5gHrdO6yiDGSaS CA== 
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 34wg61xk3t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 19 Nov 2020 02:52:50 -0500
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0AJ7hAnY023873;
        Thu, 19 Nov 2020 07:52:48 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma03ams.nl.ibm.com with ESMTP id 34weby093y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 19 Nov 2020 07:52:48 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0AJ7qjU465143162
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 19 Nov 2020 07:52:45 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BAB1D5204E;
        Thu, 19 Nov 2020 07:52:45 +0000 (GMT)
Received: from [9.145.53.92] (unknown [9.145.53.92])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 1FAA35205F;
        Thu, 19 Nov 2020 07:52:45 +0000 (GMT)
Subject: Re: [PATCH 3/6] s390/ctcm: Put struct pdu on stack.
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-s390@vger.kernel.org
Cc:     Karsten Graul <kgraul@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>
References: <20201118105317.605671-1-bigeasy@linutronix.de>
 <20201118105317.605671-4-bigeasy@linutronix.de>
From:   Julian Wiedmann <jwi@linux.ibm.com>
Message-ID: <02a2b745-03e1-f9a3-915a-fcd4d2ed00d4@linux.ibm.com>
Date:   Thu, 19 Nov 2020 09:52:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201118105317.605671-4-bigeasy@linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-19_03:2020-11-17,2020-11-19 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 clxscore=1015
 lowpriorityscore=0 spamscore=0 priorityscore=1501 mlxscore=0
 mlxlogscore=999 impostorscore=0 adultscore=0 bulkscore=0 phishscore=0
 suspectscore=2 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011190050
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 18.11.20 12:53, Sebastian Andrzej Siewior wrote:
> The size of struct pdu is 8 byte. The memory is allocated, initialized,
> used and deallocated a few lines later.
> 
> It is more efficient to avoid the allocation/free dance and keeping the
> variable on stack. Especially since the compiler is smart enough to not
> allocate the memory on stack but assign the values directly.
> 
> Add a variable pdu_hdr on stack and use it instead of p_header. p_header
> is used later as a pointer without an allocation.
> 
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Same comment, can we do a 

p_header = (struct pdu *) skb_push(...);
p_header->foo = bar;

instead? Adjusting skb->len for the length that we pushed of course.

> ---
>  drivers/s390/net/ctcm_main.c | 41 ++++++++++++------------------------
>  1 file changed, 13 insertions(+), 28 deletions(-)
> 
> diff --git a/drivers/s390/net/ctcm_main.c b/drivers/s390/net/ctcm_main.c
> index 6c7d6bbd27406..b56f51806b3d0 100644
> --- a/drivers/s390/net/ctcm_main.c
> +++ b/drivers/s390/net/ctcm_main.c
> @@ -649,6 +649,7 @@ static void ctcmpc_send_sweep_req(struct channel *rch)
>  static int ctcmpc_transmit_skb(struct channel *ch, struct sk_buff *skb)
>  {
>  	struct pdu *p_header;
> +	struct pdu pdu_hdr;
>  	struct net_device *dev = ch->netdev;
>  	struct ctcm_priv *priv = dev->ml_priv;
>  	struct mpc_group *grp = priv->mpcg;
> @@ -666,23 +667,16 @@ static int ctcmpc_transmit_skb(struct channel *ch, struct sk_buff *skb)
>  	if ((fsm_getstate(ch->fsm) != CTC_STATE_TXIDLE) || grp->in_sweep) {
>  		spin_lock_irqsave(&ch->collect_lock, saveflags);
>  		refcount_inc(&skb->users);
> -		p_header = kmalloc(PDU_HEADER_LENGTH, gfp_type());
>  
> -		if (!p_header) {
> -			spin_unlock_irqrestore(&ch->collect_lock, saveflags);
> -				goto nomem_exit;
> -		}
> -
> -		p_header->pdu_offset = skb->len;
> -		p_header->pdu_proto = 0x01;
> -		p_header->pdu_flag = 0x00;
> +		pdu_hdr.pdu_offset = skb->len;
> +		pdu_hdr.pdu_proto = 0x01;
>  		if (be16_to_cpu(skb->protocol) == ETH_P_SNAP) {
> -			p_header->pdu_flag |= PDU_FIRST | PDU_CNTL;
> +			pdu_hdr.pdu_flag = PDU_FIRST | PDU_CNTL;
>  		} else {
> -			p_header->pdu_flag |= PDU_FIRST;
> +			pdu_hdr.pdu_flag = PDU_FIRST;
>  		}
> -		p_header->pdu_seq = 0;
> -		memcpy(skb_push(skb, PDU_HEADER_LENGTH), p_header,
> +		pdu_hdr.pdu_seq = 0;
> +		memcpy(skb_push(skb, PDU_HEADER_LENGTH), &pdu_hdr,
>  		       PDU_HEADER_LENGTH);
>  
>  		CTCM_PR_DEBUG("%s(%s): Put on collect_q - skb len: %04x \n"
> @@ -692,7 +686,6 @@ static int ctcmpc_transmit_skb(struct channel *ch, struct sk_buff *skb)
>  
>  		skb_queue_tail(&ch->collect_queue, skb);
>  		ch->collect_len += skb->len;
> -		kfree(p_header);
>  
>  		spin_unlock_irqrestore(&ch->collect_lock, saveflags);
>  			goto done;
> @@ -722,23 +715,15 @@ static int ctcmpc_transmit_skb(struct channel *ch, struct sk_buff *skb)
>  		}
>  	}
>  
> -	p_header = kmalloc(PDU_HEADER_LENGTH, gfp_type());
> -
> -	if (!p_header)
> -		goto nomem_exit;
> -
> -	p_header->pdu_offset = skb->len;
> -	p_header->pdu_proto = 0x01;
> -	p_header->pdu_flag = 0x00;
> -	p_header->pdu_seq = 0;
> +	pdu_hdr.pdu_offset = skb->len;
> +	pdu_hdr.pdu_proto = 0x01;
> +	pdu_hdr.pdu_seq = 0;
>  	if (be16_to_cpu(skb->protocol) == ETH_P_SNAP) {
> -		p_header->pdu_flag |= PDU_FIRST | PDU_CNTL;
> +		pdu_hdr.pdu_flag = PDU_FIRST | PDU_CNTL;
>  	} else {
> -		p_header->pdu_flag |= PDU_FIRST;
> +		pdu_hdr.pdu_flag = PDU_FIRST;
>  	}
> -	memcpy(skb_push(skb, PDU_HEADER_LENGTH), p_header, PDU_HEADER_LENGTH);
> -
> -	kfree(p_header);
> +	memcpy(skb_push(skb, PDU_HEADER_LENGTH), &pdu_hdr, PDU_HEADER_LENGTH);
>  
>  	if (ch->collect_len > 0) {
>  		spin_lock_irqsave(&ch->collect_lock, saveflags);
> 

