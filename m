Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 65BD0130A6
	for <lists+linux-s390@lfdr.de>; Fri,  3 May 2019 16:46:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726267AbfECOql (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Fri, 3 May 2019 10:46:41 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:35330 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725283AbfECOqk (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 3 May 2019 10:46:40 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x43EMg3S136799
        for <linux-s390@vger.kernel.org>; Fri, 3 May 2019 10:27:28 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2s8n1xpmug-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Fri, 03 May 2019 10:27:28 -0400
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <heiko.carstens@de.ibm.com>;
        Fri, 3 May 2019 15:27:25 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 3 May 2019 15:27:22 +0100
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x43ERK9o54132968
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 3 May 2019 14:27:20 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 656335205A;
        Fri,  3 May 2019 14:27:20 +0000 (GMT)
Received: from osiris (unknown [9.152.212.21])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTPS id ECB785204E;
        Fri,  3 May 2019 14:27:19 +0000 (GMT)
Date:   Fri, 3 May 2019 16:27:18 +0200
From:   Heiko Carstens <heiko.carstens@de.ibm.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Martin Schwidefsky <schwidefsky@de.ibm.com>,
        clang-built-linux@googlegroups.com,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        linux-s390@vger.kernel.org, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Collin Walling <walling@linux.ibm.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/4] s390: fix clang -Wpointer-sign warnigns in boot
 code
References: <20190415083605.2560074-1-arnd@arndb.de>
 <20190415083605.2560074-4-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190415083605.2560074-4-arnd@arndb.de>
X-TM-AS-GCONF: 00
x-cbid: 19050314-0020-0000-0000-00000338F189
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19050314-0021-0000-0000-0000218B7EBB
Message-Id: <20190503142718.GF5602@osiris>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-03_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=722 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1905030091
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Mon, Apr 15, 2019 at 10:35:54AM +0200, Arnd Bergmann wrote:
> The arch/s390/boot directory is built with its own set of compiler
> options that does not include -Wno-pointer-sign like the rest of
> the kernel does, this causes a lot of harmess but correct warnings
> when building with clang.
> 
> For the atomics, we can add type casts to avoid the warnings, for
> everything else the easiest way is to slightly adapt the types
> to be more consistent.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  arch/s390/boot/ipl_parm.c       |  2 +-
>  arch/s390/include/asm/bitops.h  | 12 ++++++------
>  arch/s390/include/asm/ebcdic.h  |  2 +-
>  arch/s390/include/asm/lowcore.h |  2 +-
>  drivers/s390/char/sclp.h        |  4 ++--
>  5 files changed, 11 insertions(+), 11 deletions(-)

Applied, with typo fix and a simple coding style issue.
Thanks!

