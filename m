Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A85C2B8D8C
	for <lists+linux-s390@lfdr.de>; Thu, 19 Nov 2020 09:39:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726293AbgKSIeV (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Thu, 19 Nov 2020 03:34:21 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:60670 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726531AbgKSIeV (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 19 Nov 2020 03:34:21 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0AJ8Xcj3125080;
        Thu, 19 Nov 2020 03:34:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=UiQ0xQ2Gba4WfYFhPUz6YIAMwpdeJHwfY9/nAOR6pIw=;
 b=BESQitVLiJ2+iYP4+dX4JXWRCSLZKTXid3jU5fhOR3IH9GMY8d3dXXt1Qc2WvNWkm2ol
 91XKVLmcEKixKfVfGPvuBxdRsWRtISJsX3suACEVN2Oh0SlItANPG7lfTlqXQTP74nLY
 HcmSRWs7UTOi7Y1pbjXUITm9DtSiWuSFZT8yzpxT5T7GT73ICVJMAoFK/CSrcxR67aPT
 kG5pD4SnYzumPcS6dO9jp3wnaD+TD6BpR7Ld+ZxWvyMH4O7yGi3p2jOojfuxrFDS5JiL
 C+etY73VsjudVVjvPn2w8+RmTV+Kq5Qwwghr+Y1decoJ11KgIHk9L8Nt43Icsmoz2t77 pg== 
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0b-001b2d01.pphosted.com with ESMTP id 34wg5xqrew-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 19 Nov 2020 03:34:15 -0500
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0AJ8RFHs024059;
        Thu, 19 Nov 2020 08:31:17 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma03fra.de.ibm.com with ESMTP id 34t6v82j6w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 19 Nov 2020 08:31:17 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0AJ8VE9u14549356
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 19 Nov 2020 08:31:14 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 78E7C522BB;
        Thu, 19 Nov 2020 08:02:00 +0000 (GMT)
Received: from [9.145.53.92] (unknown [9.145.53.92])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id D62C6522B0;
        Thu, 19 Nov 2020 08:01:59 +0000 (GMT)
Subject: Re: [PATCH 0/6] s390/ctcm: Remove gfp_type() usage.
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-s390@vger.kernel.org
Cc:     Karsten Graul <kgraul@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>
References: <20201118105317.605671-1-bigeasy@linutronix.de>
From:   Julian Wiedmann <jwi@linux.ibm.com>
Message-ID: <edffa634-999e-66a0-fb21-c37803912583@linux.ibm.com>
Date:   Thu, 19 Nov 2020 10:01:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201118105317.605671-1-bigeasy@linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-19_05:2020-11-17,2020-11-19 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 bulkscore=0
 mlxscore=0 adultscore=0 mlxlogscore=951 malwarescore=0 lowpriorityscore=0
 clxscore=1015 spamscore=0 priorityscore=1501 impostorscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011190058
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 18.11.20 12:53, Sebastian Andrzej Siewior wrote:
> Folks,
> 
> in the discussion about preempt count consistency across kernel
> configurations:
>   https://lore.kernel.org/r/20200914204209.256266093@linutronix.de/
> 
> Linus clearly requested that code in drivers and libraries which changes
> behaviour based on execution context should either be split up so that
> e.g. task context invocations and BH invocations have different interfaces
> or if that's not possible the context information has to be provided by the
> caller which knows in which context it is executing.
> 
> This series is removing the gfp_type() usage which uses in_interrupt().
> Overall it appears to be a nice cleanup according to the diffstat.

Thank you for digging through this mess!

> There are still two in_irq() users left in ctcm which I'm currently
> struggling with.
> 

If that fixes the sparse complaints about unbalanced locking, it will be
very much appreciated!

> Sebastian
> 
> 

