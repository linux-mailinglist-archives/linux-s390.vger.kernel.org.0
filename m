Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C95E2BA44B
	for <lists+linux-s390@lfdr.de>; Fri, 20 Nov 2020 09:07:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725942AbgKTIHG (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Fri, 20 Nov 2020 03:07:06 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:61722 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725940AbgKTIHF (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Fri, 20 Nov 2020 03:07:05 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0AK82MoU016453;
        Fri, 20 Nov 2020 03:07:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=H4s2h/VgRaDRRWcW40el9yTuku9cPy+IMBV/PV44yoQ=;
 b=ipdI+MpjuDz3bQCpdf5YSGrP68IRSU1q2nKOIXJkY/ssVRs4LmyNPDT+2Cxr8qDnRHvg
 HydcnE/d9caP/TK6N6SBuzgYv8/pvESxkjx5rz4M7kuHo2VrOA1oxfcuS4Qqd++VEFgZ
 BWBDRmDJglvWOlM0hVjCLlXe1EqKdooG1frEKVMNW9yJmXRKLDrvLmRI/7kmvALcLLOa
 53QSswS6dstKfuPjerPxqwwRY4BIrxIfovLtYV9UTTpGml/r7cPDWA53OTbLkj5rC8WY
 mVbwDFqLv2TEJBbVgDbS/klkVWAiYpqsngPMtJZsriNrjnisFyK0l2j/eZdNXwDUvN7U Eg== 
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 34x8v0hy1r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 20 Nov 2020 03:07:02 -0500
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0AK81xRh031443;
        Fri, 20 Nov 2020 08:07:01 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma03ams.nl.ibm.com with ESMTP id 34weby1evq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 20 Nov 2020 08:07:01 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0AK86wlE60359090
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 20 Nov 2020 08:06:58 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 65B9211C081;
        Fri, 20 Nov 2020 08:06:58 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B128811C05E;
        Fri, 20 Nov 2020 08:06:57 +0000 (GMT)
Received: from [9.145.74.155] (unknown [9.145.74.155])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 20 Nov 2020 08:06:57 +0000 (GMT)
Subject: Re: [PATCH v2 0/6] s390/ctcm: Remove gfp_type() usage.
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-s390@vger.kernel.org
Cc:     Karsten Graul <kgraul@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>
References: <20201119135719.983170-1-bigeasy@linutronix.de>
From:   Julian Wiedmann <jwi@linux.ibm.com>
Message-ID: <d40cf363-c4e0-8f2b-6a39-c180c0f00338@linux.ibm.com>
Date:   Fri, 20 Nov 2020 10:06:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201119135719.983170-1-bigeasy@linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-20_03:2020-11-19,2020-11-20 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 lowpriorityscore=0 adultscore=0 priorityscore=1501 mlxlogscore=999
 clxscore=1015 mlxscore=0 malwarescore=0 bulkscore=0 phishscore=0
 suspectscore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2009150000 definitions=main-2011200048
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 19.11.20 15:57, Sebastian Andrzej Siewior wrote:
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
> 
> v1…v2:
> 	- Use the pointer from skb_put()/push() instead having it on
> 	  stack.
> 	- Collect acks for patch 4-6.
> 
> Sebastian
> 
> 

Thank you Sebastian! All applied.
