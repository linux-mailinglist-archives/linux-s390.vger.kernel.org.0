Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 07EA61644A2
	for <lists+linux-s390@lfdr.de>; Wed, 19 Feb 2020 13:49:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726840AbgBSMtq (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Wed, 19 Feb 2020 07:49:46 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:45708 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726786AbgBSMtq (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 19 Feb 2020 07:49:46 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01JCnPum089662
        for <linux-s390@vger.kernel.org>; Wed, 19 Feb 2020 07:49:45 -0500
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2y8ubx3pvt-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Wed, 19 Feb 2020 07:49:44 -0500
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <gor@linux.ibm.com>;
        Wed, 19 Feb 2020 12:49:43 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 19 Feb 2020 12:49:41 -0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 01JCneuB45940794
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 Feb 2020 12:49:40 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 16235AE051;
        Wed, 19 Feb 2020 12:49:40 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CF97FAE055;
        Wed, 19 Feb 2020 12:49:39 +0000 (GMT)
Received: from localhost (unknown [9.152.212.204])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Wed, 19 Feb 2020 12:49:39 +0000 (GMT)
Date:   Wed, 19 Feb 2020 13:49:38 +0100
From:   Vasily Gorbik <gor@linux.ibm.com>
To:     Stephen Kitt <steve@sk2.org>
Cc:     Heiko Carstens <heiko.carstens@de.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] s390: remove obsolete ieee_emulation_warnings
References: <20200214172628.3598516-1-steve@sk2.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200214172628.3598516-1-steve@sk2.org>
X-TM-AS-GCONF: 00
x-cbid: 20021912-4275-0000-0000-000003A3717E
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20021912-4276-0000-0000-000038B77B58
Message-Id: <your-ad-here.call-01582116578-ext-5731@work.hours>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-19_03:2020-02-19,2020-02-19 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 phishscore=0 clxscore=1015 malwarescore=0 adultscore=0 mlxlogscore=667
 spamscore=0 suspectscore=1 mlxscore=0 bulkscore=0 impostorscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002190097
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Fri, Feb 14, 2020 at 06:26:28PM +0100, Stephen Kitt wrote:
> s390 math emulation was removed with commit 5a79859ae0f3 ("s390:
> remove 31 bit support"), rendering ieee_emulation_warnings useless.
> The code still built because it was protected by CONFIG_MATHEMU, which
> was no longer selectable.
> 
> This patch removes the sysctl_ieee_emulation_warnings declaration and
> the sysctl entry declaration.
> 
> Signed-off-by: Stephen Kitt <steve@sk2.org>
> ---
>  arch/s390/include/asm/processor.h | 1 -
>  kernel/sysctl.c                   | 9 ---------
>  2 files changed, 10 deletions(-)

Applied, thanks!

