Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0A0B73B89B
	for <lists+linux-s390@lfdr.de>; Mon, 10 Jun 2019 17:54:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390751AbfFJPx4 (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Mon, 10 Jun 2019 11:53:56 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:58970 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2390550AbfFJPx4 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 10 Jun 2019 11:53:56 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5AFpZix015568
        for <linux-s390@vger.kernel.org>; Mon, 10 Jun 2019 11:53:55 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2t1t7er3px-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Mon, 10 Jun 2019 11:53:55 -0400
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <heiko.carstens@de.ibm.com>;
        Mon, 10 Jun 2019 16:53:53 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 10 Jun 2019 16:53:51 +0100
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x5AFroZt36503572
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 10 Jun 2019 15:53:50 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5DCE5A405F;
        Mon, 10 Jun 2019 15:53:50 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1CA9FA405C;
        Mon, 10 Jun 2019 15:53:50 +0000 (GMT)
Received: from osiris (unknown [9.145.162.214])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Mon, 10 Jun 2019 15:53:50 +0000 (GMT)
Date:   Mon, 10 Jun 2019 17:53:48 +0200
From:   Heiko Carstens <heiko.carstens@de.ibm.com>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] s390: mark __ctl_set_bit and __ctl_clear_bit as
 __always_inline
References: <1560112544-10440-1-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1560112544-10440-1-git-send-email-linux@roeck-us.net>
X-TM-AS-GCONF: 00
x-cbid: 19061015-0028-0000-0000-00000379007C
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19061015-0029-0000-0000-00002438EB60
Message-Id: <20190610155348.GA4031@osiris>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-10_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=841 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906100108
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Sun, Jun 09, 2019 at 01:35:44PM -0700, Guenter Roeck wrote:
> s390:tinyconfig fails to build with gcc 8.3.0.
...
> Marking __ctl_set_bit and __ctl_clear_bit as __always_inline fixes the
> problem.
> 
> Fixes: 9012d011660e ("compiler: allow all arches to enable CONFIG_OPTIMIZE_INLINING")
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
>  arch/s390/include/asm/ctl_reg.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Applied, thanks!

