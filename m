Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9E2A2BA448
	for <lists+linux-s390@lfdr.de>; Fri, 20 Nov 2020 09:07:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726334AbgKTIFy (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Fri, 20 Nov 2020 03:05:54 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:33916 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726786AbgKTIFy (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Fri, 20 Nov 2020 03:05:54 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0AK82I2C016354;
        Fri, 20 Nov 2020 03:05:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=CSmFHvJToIVcmEP2PiPEpdhYm9bL5tgUsQYRyPDaZ7w=;
 b=NmwLFjW+qMcBwM0mxxw/UOxOdhaCUlI8faz2SiLyZLJ2uaLJIUed75SFSdIY2ueE/3P1
 ksmmODAzuPl443vh51YD8Vsps7fA379a3IYnEJO6F1nI9ADk/snIwVJIWD7bJ+l/8lUF
 Tv9bLP4RDkdR657gTkbPD7BcdYWd2qmRldcOsodNPVh23d8iGKwYtoXKn9c3t8V+cHni
 l2xl8+XxoimLEbI2FaVwClSKm22RPbl3Uy8PlpnG3pBrBT4XIHiXAI5bcfrkqoZnys0W
 qPnUKc4OAignwob0KCAI/8LA7XbHWF67ffAsiimU+P7QMvTN5yTkMQvozvCbBRT9VklG oA== 
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 34x8v0hwsa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 20 Nov 2020 03:05:51 -0500
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0AK81eLa031336;
        Fri, 20 Nov 2020 08:05:49 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma03ams.nl.ibm.com with ESMTP id 34weby1eup-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 20 Nov 2020 08:05:49 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0AK85ksx60817664
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 20 Nov 2020 08:05:46 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4D87B11C052;
        Fri, 20 Nov 2020 08:05:46 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B16A711C09C;
        Fri, 20 Nov 2020 08:05:45 +0000 (GMT)
Received: from [9.145.74.155] (unknown [9.145.74.155])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 20 Nov 2020 08:05:45 +0000 (GMT)
Subject: Re: [PATCH v2 3/6] s390/ctcm: Avoid temporary allocation of struct
 pdu.
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-s390@vger.kernel.org
Cc:     Karsten Graul <kgraul@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>
References: <20201119135719.983170-1-bigeasy@linutronix.de>
 <20201119135719.983170-4-bigeasy@linutronix.de>
From:   Julian Wiedmann <jwi@linux.ibm.com>
Message-ID: <a20c5577-b217-68b1-f433-51dc0843aa37@linux.ibm.com>
Date:   Fri, 20 Nov 2020 10:05:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201119135719.983170-4-bigeasy@linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-20_03:2020-11-19,2020-11-20 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 lowpriorityscore=0 adultscore=0 priorityscore=1501 mlxlogscore=999
 clxscore=1015 mlxscore=0 malwarescore=0 bulkscore=0 phishscore=0
 suspectscore=2 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2009150000 definitions=main-2011200048
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 19.11.20 15:57, Sebastian Andrzej Siewior wrote:
> The size of struct pdu is 8 byte. The memory is allocated, initialized,
> used and deallocated a few lines later.
> 
> It is more efficient to avoid the allocation/free dance and assign the
> values directly to skb's data part instead of using memcpy() for it.
> 
> Avoid an allocation of struct pdu and use the resulting skb pointer instead.
> 
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
>  drivers/s390/net/ctcm_main.c | 29 ++++++-----------------------
>  1 file changed, 6 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/s390/net/ctcm_main.c b/drivers/s390/net/ctcm_main.c
> index a3a74ebfee635..0cb130c280031 100644
> --- a/drivers/s390/net/ctcm_main.c
> +++ b/drivers/s390/net/ctcm_main.c
> @@ -666,24 +666,16 @@ static int ctcmpc_transmit_skb(struct channel *ch, struct sk_buff *skb)
>  	if ((fsm_getstate(ch->fsm) != CTC_STATE_TXIDLE) || grp->in_sweep) {
>  		spin_lock_irqsave(&ch->collect_lock, saveflags);
>  		refcount_inc(&skb->users);
> -		p_header = kmalloc(PDU_HEADER_LENGTH, gfp_type());
> -
> -		if (!p_header) {
> -			spin_unlock_irqrestore(&ch->collect_lock, saveflags);
> -				goto nomem_exit;
> -		}
>  
> +		p_header = skb_push(skb, PDU_HEADER_LENGTH);
>  		p_header->pdu_offset = skb->len;

I mentioned this in my reply to v1 - here we now need to adjust skb->len
for the pushed length. Will fix up while applying (also below).

>  		p_header->pdu_proto = 0x01;
> -		p_header->pdu_flag = 0x00;
>  		if (be16_to_cpu(skb->protocol) == ETH_P_SNAP) {
> -			p_header->pdu_flag |= PDU_FIRST | PDU_CNTL;
> +			p_header->pdu_flag = PDU_FIRST | PDU_CNTL;
>  		} else {
> -			p_header->pdu_flag |= PDU_FIRST;
> +			p_header->pdu_flag = PDU_FIRST;
>  		}
>  		p_header->pdu_seq = 0;
> -		memcpy(skb_push(skb, PDU_HEADER_LENGTH), p_header,
> -		       PDU_HEADER_LENGTH);
>  
>  		CTCM_PR_DEBUG("%s(%s): Put on collect_q - skb len: %04x \n"
>  				"pdu header and data for up to 32 bytes:\n",
> @@ -692,7 +684,6 @@ static int ctcmpc_transmit_skb(struct channel *ch, struct sk_buff *skb)
>  
>  		skb_queue_tail(&ch->collect_queue, skb);
>  		ch->collect_len += skb->len;
> -		kfree(p_header);
>  
>  		spin_unlock_irqrestore(&ch->collect_lock, saveflags);
>  			goto done;
> @@ -722,23 +713,15 @@ static int ctcmpc_transmit_skb(struct channel *ch, struct sk_buff *skb)
>  		}
>  	}
>  
> -	p_header = kmalloc(PDU_HEADER_LENGTH, gfp_type());
> -
> -	if (!p_header)
> -		goto nomem_exit;
> -
> +	p_header = skb_push(skb, PDU_HEADER_LENGTH);
>  	p_header->pdu_offset = skb->len;
>  	p_header->pdu_proto = 0x01;
> -	p_header->pdu_flag = 0x00;
>  	p_header->pdu_seq = 0;
>  	if (be16_to_cpu(skb->protocol) == ETH_P_SNAP) {
> -		p_header->pdu_flag |= PDU_FIRST | PDU_CNTL;
> +		p_header->pdu_flag = PDU_FIRST | PDU_CNTL;
>  	} else {
> -		p_header->pdu_flag |= PDU_FIRST;
> +		p_header->pdu_flag = PDU_FIRST;
>  	}
> -	memcpy(skb_push(skb, PDU_HEADER_LENGTH), p_header, PDU_HEADER_LENGTH);
> -
> -	kfree(p_header);
>  
>  	if (ch->collect_len > 0) {
>  		spin_lock_irqsave(&ch->collect_lock, saveflags);
> 

