Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE6A12B8C63
	for <lists+linux-s390@lfdr.de>; Thu, 19 Nov 2020 08:31:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726155AbgKSHaa (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Thu, 19 Nov 2020 02:30:30 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:40006 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725888AbgKSHaa (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 19 Nov 2020 02:30:30 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0AJ72Gkf108183;
        Thu, 19 Nov 2020 02:30:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=58v7++a9RF1oplTM0qg+E/TZtySoDQqIMGY3+Bk9Ksg=;
 b=VdzWkN83Ro7lTmtMUA6t+OkPvnnUa7oK8LE4sOgpMXB1UNZHFrVWYeB/tY2KSQ9Ics0l
 l6ERexW8tjXPvsmk7+/Pj9vn/AnEYP377p+52SPLVcT10ZAEZiolQIqGFKcilDk6roGH
 ZYfXUGE7M/DgTjM/0c+CilaqnRcEOfUWuc85fyYDI388n5Jiu1bqjy54kjTJoNEMVUO7
 mskfmMNRu698JkUgRmQkwhjbvx10TAKGcAF8D6kUenNrOEZSmTk9KnO56oz6AlcOXU+6
 apBMp0XdShs2AEtnYccs6Cf+G6+nV1lWq0PFVvMXZsqBQf3l+qzjNN7Hp6Ss8E+Pp2X8 YA== 
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 34wg61x0yt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 19 Nov 2020 02:30:27 -0500
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0AJ7NUUQ028626;
        Thu, 19 Nov 2020 07:30:25 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma04ams.nl.ibm.com with ESMTP id 34t6v8cnpw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 19 Nov 2020 07:30:25 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0AJ7UMnt44040652
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 19 Nov 2020 07:30:22 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B080152074;
        Thu, 19 Nov 2020 07:30:22 +0000 (GMT)
Received: from [9.145.53.92] (unknown [9.145.53.92])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 2943E52059;
        Thu, 19 Nov 2020 07:30:22 +0000 (GMT)
Subject: Re: [PATCH 5/6] s390/ctcm: Use GFP_KERNEL in add_channel().
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-s390@vger.kernel.org
Cc:     Karsten Graul <kgraul@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>
References: <20201118105317.605671-1-bigeasy@linutronix.de>
 <20201118105317.605671-6-bigeasy@linutronix.de>
From:   Julian Wiedmann <jwi@linux.ibm.com>
Message-ID: <f09c3bdd-bb0b-4b77-ba64-675393100b55@linux.ibm.com>
Date:   Thu, 19 Nov 2020 09:30:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201118105317.605671-6-bigeasy@linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-19_03:2020-11-17,2020-11-19 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 clxscore=1015
 lowpriorityscore=0 spamscore=0 priorityscore=1501 mlxscore=0
 mlxlogscore=999 impostorscore=0 adultscore=0 bulkscore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011190047
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
> The memory allocation of `ch' a few lines above is using GFP_KERNEL,
> also an allocation a few lines later is using GFP_KERNEL.
> 
> Use GFP_KERNEL for the memory allocation.
> 
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Reviewed-by: Julian Wiedmann <jwi@linux.ibm.com>
