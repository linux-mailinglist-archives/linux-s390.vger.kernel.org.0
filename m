Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CF212B8C60
	for <lists+linux-s390@lfdr.de>; Thu, 19 Nov 2020 08:31:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725813AbgKSH2m (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Thu, 19 Nov 2020 02:28:42 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:30376 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725802AbgKSH2m (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 19 Nov 2020 02:28:42 -0500
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0AJ751qh153608;
        Thu, 19 Nov 2020 02:28:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=26XEIyMhRSImHvdGpRaxiyDQ0UL+MJf50whxrqkSeX0=;
 b=aTAlF1BfL0iDm6qayTrULCGccz7c1XrXfS3PT/pBuIXT8ug/yCFX0PLHjwXbmyokqpfe
 57aJRVxGT6TkvytqMcx0nV/FxLtATubhqjofJiU8bItxd9UT8hlW2meJJ1VsIAoNTY2a
 7qU0ARiO7shqznrUzRunwVfTH5+v3OqkICoKGxKNQHahN/y1z+f+UNvEwY84tUuOiHdz
 /zM9GmBFN6GDE+7kaEyKNlKJMjnNFL7qZUVMfz44AAiRGhbTXwVGtUHZhHQdnGL+LIXN
 KJlHZcGiYUb7LVTFGH4v34kRTQRA7ttUWCy0G/9zT2+ndONLVcM3oot6PPPNGox60nI4 CQ== 
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com with ESMTP id 34wg645nb9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 19 Nov 2020 02:28:31 -0500
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0AJ7Nk3r020359;
        Thu, 19 Nov 2020 07:28:28 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma06ams.nl.ibm.com with ESMTP id 34w4yfgpc8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 19 Nov 2020 07:28:28 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0AJ7SP9B61276662
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 19 Nov 2020 07:28:26 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DC7345204E;
        Thu, 19 Nov 2020 07:28:25 +0000 (GMT)
Received: from [9.145.53.92] (unknown [9.145.53.92])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 4B68E52050;
        Thu, 19 Nov 2020 07:28:25 +0000 (GMT)
Subject: Re: [PATCH 4/6] s390/ctcm: Use explicit allocation mask in
 ctcmpc_unpack_skb().
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-s390@vger.kernel.org
Cc:     Karsten Graul <kgraul@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>
References: <20201118105317.605671-1-bigeasy@linutronix.de>
 <20201118105317.605671-5-bigeasy@linutronix.de>
From:   Julian Wiedmann <jwi@linux.ibm.com>
Message-ID: <1b886820-3cff-f8d4-46aa-0ec6fbe248bd@linux.ibm.com>
Date:   Thu, 19 Nov 2020 09:28:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201118105317.605671-5-bigeasy@linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-19_03:2020-11-17,2020-11-19 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 clxscore=1011
 bulkscore=0 spamscore=0 impostorscore=0 mlxlogscore=990 lowpriorityscore=0
 malwarescore=0 adultscore=0 mlxscore=0 suspectscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011190050
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 18.11.20 12:53, Sebastian Andrzej Siewior wrote:
> gfp_type() uses in_interrupt() to figure out the correct GFP mask.
> 
> The usage of in_interrupt() in drivers is phased out and Linus clearly
> requested that code which changes behaviour depending on context should
> either be separated or the context be conveyed in an argument passed by the
> caller, which usually knows the context.
> 
> The call chain of ctcmpc_unpack_skb():
> ctcmpc_bh()
>  -> ctcmpc_unpack_skb()
> 
> ctcmpc_bh() is a tasklet handler so GFP_ATOMIC is needed.
> 
> Use GFP_ATOMIC as allocation type in ctcmpc_unpack_skb().
> 
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Reviewed-by: Julian Wiedmann <jwi@linux.ibm.com>
