Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B880F13091
	for <lists+linux-s390@lfdr.de>; Fri,  3 May 2019 16:39:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726463AbfECOjs (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Fri, 3 May 2019 10:39:48 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:51636 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725809AbfECOjs (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 3 May 2019 10:39:48 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x43EcBUM145914
        for <linux-s390@vger.kernel.org>; Fri, 3 May 2019 10:39:47 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2s8q2jhfqc-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Fri, 03 May 2019 10:39:47 -0400
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <heiko.carstens@de.ibm.com>;
        Fri, 3 May 2019 15:39:45 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 3 May 2019 15:39:43 +0100
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x43Edf8a54919214
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 3 May 2019 14:39:41 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C0007A404D;
        Fri,  3 May 2019 14:39:41 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7C40DA405D;
        Fri,  3 May 2019 14:39:41 +0000 (GMT)
Received: from osiris (unknown [9.152.212.21])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Fri,  3 May 2019 14:39:41 +0000 (GMT)
Date:   Fri, 3 May 2019 16:39:40 +0200
From:   Heiko Carstens <heiko.carstens@de.ibm.com>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Martin Schwidefsky <schwidefsky@de.ibm.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Philipp Rudo <prudo@linux.ibm.com>,
        linux-s390 <linux-s390@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] s390: vdso: drop unnecessary cc-ldoption
References: <20190423210058.249510-1-ndesaulniers@google.com>
 <CAKwvOd=aR_GsJkaMTtV83UAAyqkZGuToD+3Zbq5sv=U_bogXmg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKwvOd=aR_GsJkaMTtV83UAAyqkZGuToD+3Zbq5sv=U_bogXmg@mail.gmail.com>
X-TM-AS-GCONF: 00
x-cbid: 19050314-0020-0000-0000-00000338F262
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19050314-0021-0000-0000-0000218B7FA3
Message-Id: <20190503143940.GH5602@osiris>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-03_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=948 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1905030093
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Tue, Apr 30, 2019 at 01:25:09PM -0700, Nick Desaulniers wrote:
> On Tue, Apr 23, 2019 at 2:01 PM Nick Desaulniers
> <ndesaulniers@google.com> wrote:
> >
> > Towards the goal of removing cc-ldoption, it seems that --hash-style=
> > was added to binutils 2.17.50.0.2 in 2006. The minimal required version
> > of binutils for the kernel according to
> > Documentation/process/changes.rst is 2.20.
> >
> > Link: https://gcc.gnu.org/ml/gcc/2007-01/msg01141.html
> > Cc: clang-built-linux@googlegroups.com
> > Suggested-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> > Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
> > ---
> >  arch/s390/kernel/vdso32/Makefile | 2 +-
> >  arch/s390/kernel/vdso64/Makefile | 2 +-
> >  2 files changed, 2 insertions(+), 2 deletions(-)
...
> bumping for review

Sorry for the delay! Applied now, thanks.

