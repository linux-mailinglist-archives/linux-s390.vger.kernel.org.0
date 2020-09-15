Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E908D26AA99
	for <lists+linux-s390@lfdr.de>; Tue, 15 Sep 2020 19:29:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727856AbgIOR2z (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Tue, 15 Sep 2020 13:28:55 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:33284 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727872AbgIOR1H (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 15 Sep 2020 13:27:07 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 08FGUwJa060147;
        Tue, 15 Sep 2020 12:49:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=sUK859z+v7TlZ+SzJkxrk+NALBamWMtBN9S4UfP4sXQ=;
 b=oVlhwWrjnCR5MnlzFY8c+DzRr4tHjlejlecjSEqANKXIHbZUN7lkEaBwp1uI49kxuF8C
 rYyxhDsnX2PgMwCjvi7jq0EZUVcor+45qrPKJ0b1oqFC9vGIgFeCal0s//UCd2fGnm3b
 95dXmQ16XaLYuuqPYMCmkD8hrpM1r4THnIHanVec8IsUc0Ko/ool4OH1CUh+XMT1pLFR
 JTpy51AWav8JokUCjU3iVMqjo0S8aMMxvZfW+YNxPguY0fTGf4WLuS3M2PpGBi7581Su
 hRGaaPoF60JRvQXa1xlnO/Fu3XUGxwS53yeLi7XIZWtzTsJtCi4vxOt5dkIYXLG5ar2x Mg== 
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0b-001b2d01.pphosted.com with ESMTP id 33jwub0dun-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 15 Sep 2020 12:49:15 -0400
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 08FGgiu7019762;
        Tue, 15 Sep 2020 16:49:14 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma06fra.de.ibm.com with ESMTP id 33hjgdsbh7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 15 Sep 2020 16:49:14 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 08FGnB8w28705164
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Sep 2020 16:49:11 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 30B52A405F;
        Tue, 15 Sep 2020 16:49:11 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DFD11A4054;
        Tue, 15 Sep 2020 16:49:10 +0000 (GMT)
Received: from osiris (unknown [9.171.78.178])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Tue, 15 Sep 2020 16:49:10 +0000 (GMT)
Date:   Tue, 15 Sep 2020 18:49:09 +0200
From:   Heiko Carstens <hca@linux.ibm.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Harald Freudenberger <freude@linux.ibm.com>,
        linux-s390@vger.kernel.org
Subject: Re: [PATCH 4/4] s390/uaccess: remove set_fs() interface
Message-ID: <20200915164909.GB11180@osiris>
References: <20200915154340.4215-1-hca@linux.ibm.com>
 <20200915154340.4215-5-hca@linux.ibm.com>
 <20200915160243.GB22056@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200915160243.GB22056@lst.de>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-15_11:2020-09-15,2020-09-15 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 spamscore=0
 priorityscore=1501 phishscore=0 lowpriorityscore=0 clxscore=1015
 mlxlogscore=558 bulkscore=0 adultscore=0 impostorscore=0 suspectscore=1
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009150130
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Tue, Sep 15, 2020 at 06:02:43PM +0200, Christoph Hellwig wrote:
> >  	int oldval = 0, newval, ret;
> > -	mm_segment_t old_fs;
> > +	bool old;
> >  
> > -	old_fs = enable_sacf_uaccess();
> > +	old = enable_sacf_uaccess();
> >  	switch (op) {
> >  	case FUTEX_OP_SET:
> >  		__futex_atomic_op("lr %2,%5\n",
> > @@ -53,7 +53,7 @@ static inline int arch_futex_atomic_op_inuser(int op, int oparg, int *oval,
> >  	default:
> >  		ret = -ENOSYS;
> >  	}
> > -	disable_sacf_uaccess(old_fs);
> > +	disable_sacf_uaccess(old);
> 
> Do we need to return the old value here?  The way I understand it
> this is context switched with the thread, and given that only small
> isolated code bases now use it, sacf use can't nest, can it?

Right, that should not happen. I think I'll change both functions to
void and add a WARN_ON_ONCE() to both of them, so that nested calls
will be catched.

> > @@ -116,7 +114,7 @@ struct thread_struct {
> >  	unsigned long hardirq_timer;	/* task cputime in hardirq context */
> >  	unsigned long softirq_timer;	/* task cputime in softirq context */
> >  	unsigned long sys_call_table;	/* system call table address */
> > -	mm_segment_t mm_segment;
> > +	bool sacf_uaccess;		/* uaccess with sacf enabled */
> 
> Isn't there a flags field somewhere where this could be folded into?

Hmm, a TIF flag will probably do.

> > -void set_fs_fixup(void)
> > -{
> > -	struct pt_regs *regs = current_pt_regs();
> > -	static bool warned;
> > -
> > -	set_fs(USER_DS);
> > -	if (warned)
> > -		return;
> > -	WARN(1, "Unbalanced set_fs - int code: 0x%x\n", regs->int_code);
> > -	show_registers(regs);
> > -	warned = true;
> 
> Would a warning about an unbalanced sacf flag still make sense?  Or
> just objtool for compile time checks similar to the unsafe uaccess
> routines on x86?

Yes, I was not sure to keep it or drop it. But now that you ask for
it, I'll add it back. FWIW, there is no objtool for s390 (yet).

> >  EXPORT_SYMBOL(enable_sacf_uaccess);
> 
> Neither enable_sacf_uaccess nor disable_sacf_uaccess appear to be
> used in modular code, so these exports can probably be dropped.

Ah, I wanted to check, and forgot that.
