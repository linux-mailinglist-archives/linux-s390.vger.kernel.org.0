Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8A27C19579C
	for <lists+linux-s390@lfdr.de>; Fri, 27 Mar 2020 13:58:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727347AbgC0M6u (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Fri, 27 Mar 2020 08:58:50 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:21032 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727143AbgC0M6u (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Fri, 27 Mar 2020 08:58:50 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02RCY1D3127101
        for <linux-s390@vger.kernel.org>; Fri, 27 Mar 2020 08:58:49 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2ywd8gwcwf-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Fri, 27 Mar 2020 08:58:48 -0400
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <heiko.carstens@de.ibm.com>;
        Fri, 27 Mar 2020 12:58:45 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 27 Mar 2020 12:58:42 -0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 02RCwfla42270880
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 27 Mar 2020 12:58:41 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BF0A411C04A;
        Fri, 27 Mar 2020 12:58:41 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 653B311C050;
        Fri, 27 Mar 2020 12:58:41 +0000 (GMT)
Received: from osiris (unknown [9.145.49.166])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Fri, 27 Mar 2020 12:58:41 +0000 (GMT)
Date:   Fri, 27 Mar 2020 13:58:40 +0100
From:   Heiko Carstens <heiko.carstens@de.ibm.com>
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Julian Wiedmann <jwi@linux.ibm.com>,
        Ursula Braun <ubraun@linux.ibm.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
Subject: Re: [PATCH -next v2] s390/ism: Remove PM support
References: <20200326190549.24565-1-natechancellor@gmail.com>
 <20200326190741.24687-1-natechancellor@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200326190741.24687-1-natechancellor@gmail.com>
X-TM-AS-GCONF: 00
x-cbid: 20032712-0028-0000-0000-000003ECD70A
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20032712-0029-0000-0000-000024B24F2F
Message-Id: <20200327125840.GA4109@osiris>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.645
 definitions=2020-03-27_04:2020-03-27,2020-03-27 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 malwarescore=0 mlxlogscore=966 spamscore=0 lowpriorityscore=0 phishscore=0
 adultscore=0 priorityscore=1501 bulkscore=0 impostorscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2003270111
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Thu, Mar 26, 2020 at 12:07:44PM -0700, Nathan Chancellor wrote:
> Clang warns:
> 
> drivers/s390/net/ism_drv.c:570:12: warning: unused function
> 'ism_suspend' [-Wunused-function]
> static int ism_suspend(struct device *dev)
>            ^
> drivers/s390/net/ism_drv.c:578:12: warning: unused function 'ism_resume'
> [-Wunused-function]
> static int ism_resume(struct device *dev)
>            ^
> 2 warnings generated.
> 
> When CONFIG_PM is unset, SIMPLE_DEV_PM_OPS does not use the suspend or
> resume functions. Power management was recently ripped out of s390 so
> CONFIG_PM will never be set and these functions will always be unused.
> 
> Remove them so that there is no more warning.
> 
> Link: https://github.com/ClangBuiltLinux/linux/issues/950
> Fixes: 394216275c7d ("s390: remove broken hibernate / power management support")
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>

Thank you, however there was already an identical patch from Ursula
which was missing on our branch. It's now there:

https://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git/commit/?h=features&id=194f75706b86847d1b4237958f7d6bd7ea7baf42

