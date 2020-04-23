Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DC661B5D4A
	for <lists+linux-s390@lfdr.de>; Thu, 23 Apr 2020 16:08:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726637AbgDWOI1 (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Thu, 23 Apr 2020 10:08:27 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:27292 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726377AbgDWOI0 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 23 Apr 2020 10:08:26 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03NE3O8K139463;
        Thu, 23 Apr 2020 10:08:25 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 30k09wnker-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 23 Apr 2020 10:08:25 -0400
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 03NE48tt143456;
        Thu, 23 Apr 2020 10:08:25 -0400
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 30k09wnkdn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 23 Apr 2020 10:08:25 -0400
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 03NE5Lxf009436;
        Thu, 23 Apr 2020 14:08:22 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma03ams.nl.ibm.com with ESMTP id 30fs65818s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 23 Apr 2020 14:08:22 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 03NE8KPc65667514
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 23 Apr 2020 14:08:20 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 17938AE051;
        Thu, 23 Apr 2020 14:08:20 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9275EAE056;
        Thu, 23 Apr 2020 14:08:19 +0000 (GMT)
Received: from p-imbrenda (unknown [9.145.4.105])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 23 Apr 2020 14:08:19 +0000 (GMT)
Date:   Thu, 23 Apr 2020 16:08:17 +0200
From:   Claudio Imbrenda <imbrenda@linux.ibm.com>
To:     Vasily Gorbik <gor@linux.ibm.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org, borntraeger@de.ibm.com,
        frankja@linux.ibm.com, cohuck@redhat.com, david@redhat.com,
        kbuild test robot <lkp@intel.com>,
        Philipp Rudo <prudo@linux.ibm.com>
Subject: Re: [PATCH v1 1/1] s390/protvirt: fix compilation issue
Message-ID: <20200423160817.2bc7b3fa@p-imbrenda>
In-Reply-To: <your-ad-here.call-01587646462-ext-4177@work.hours>
References: <20200423120114.2027410-1-imbrenda@linux.ibm.com>
        <your-ad-here.call-01587646462-ext-4177@work.hours>
Organization: IBM
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-23_10:2020-04-23,2020-04-23 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=0 phishscore=0 clxscore=1015 adultscore=0 mlxlogscore=999
 bulkscore=0 impostorscore=0 spamscore=0 mlxscore=0 priorityscore=1501
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004230112
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Thu, 23 Apr 2020 14:54:22 +0200
Vasily Gorbik <gor@linux.ibm.com> wrote:

> On Thu, Apr 23, 2020 at 02:01:14PM +0200, Claudio Imbrenda wrote:
> > The kernel fails to compile with
> > CONFIG_PROTECTED_VIRTUALIZATION_GUEST set but CONFIG_KVM unset.
> > 
> > This patch fixes the issue by making the needed variable always
> > available.  
> 
> This statement confuses me a bit.
> 
> It's worth to mention that both arch/s390/boot/uv.c (for the
> decompressor) and arch/s390/kernel/uv.c (for the main kernel) are only
> built when either CONFIG_PROTECTED_VIRTUALIZATION_GUEST or
> CONFIG_KVM is enabled.
> Both arch/s390/boot/Makefile and arch/s390/kernel/Makefile contain:
> obj-$(findstring y, $(CONFIG_PROTECTED_VIRTUALIZATION_GUEST)
> $(CONFIG_PGSTE))   += uv.o
> 
> So this makes the variable available when
> CONFIG_PROTECTED_VIRTUALIZATION_GUEST or CONFIG_KVM (expressed via
> CONFIG_PGSTE) is enabled. Hence no need for extra conditions for
> variable declaration.

yes, "always available" when the file is compiled at all, obviously.

in fact, there are some probably useless ifdefs in that file too, but
this patch should only address the bug

> > Fixes: a0f60f8431999bf5 ("s390/protvirt: Add sysfs firmware
> > interface for Ultravisor information") Reported-by: kbuild test
> > robot <lkp@intel.com> Reported-by: Philipp Rudo
> > <prudo@linux.ibm.com> Suggested-by: Philipp Rudo
> > <prudo@linux.ibm.com> CC: Vasily Gorbik <gor@linux.ibm.com>
> > Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
> > ---
> >  arch/s390/boot/uv.c   | 2 --
> >  arch/s390/kernel/uv.c | 3 ++-
> >  2 files changed, 2 insertions(+), 3 deletions(-)
> > 
> > diff --git a/arch/s390/boot/uv.c b/arch/s390/boot/uv.c
> > index 8fde561f1d07..f887a479cdc7 100644
> > --- a/arch/s390/boot/uv.c
> > +++ b/arch/s390/boot/uv.c
> > @@ -7,9 +7,7 @@
> >  #ifdef CONFIG_PROTECTED_VIRTUALIZATION_GUEST
> >  int __bootdata_preserved(prot_virt_guest);
> >  #endif
> > -#if IS_ENABLED(CONFIG_KVM)
> >  struct uv_info __bootdata_preserved(uv_info);
> > -#endif
> >  
> >  void uv_query_info(void)
> >  {
> > diff --git a/arch/s390/kernel/uv.c b/arch/s390/kernel/uv.c
> > index c86d654351d1..4c0677fc8904 100644
> > --- a/arch/s390/kernel/uv.c
> > +++ b/arch/s390/kernel/uv.c
> > @@ -23,10 +23,11 @@
> >  int __bootdata_preserved(prot_virt_guest);
> >  #endif
> >  
> > +struct uv_info __bootdata_preserved(uv_info);
> > +
> >  #if IS_ENABLED(CONFIG_KVM)
> >  int prot_virt_host;
> >  EXPORT_SYMBOL(prot_virt_host);
> > -struct uv_info __bootdata_preserved(uv_info);
> >  EXPORT_SYMBOL(uv_info);  
> 
> hm, EXPORT_SYMBOL(uv_info) is not needed without CONFIG_KVM and this
> saves 1 symbol export, but I'd still made EXPORT_SYMBOL follow the
> declaration immediately. Documentation/process/coding-style.rst
> mentions that only for function declarations though.

I was wondering the same regarding the export.

I don't have any strong opinions, so if anyone has a preference, speak
up and I can fix it.

> Reviewed-by: Vasily Gorbik <gor@linux.ibm.com>

