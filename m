Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73D3F23ADFF
	for <lists+linux-s390@lfdr.de>; Mon,  3 Aug 2020 22:13:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727864AbgHCUMg (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Mon, 3 Aug 2020 16:12:36 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:39504 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726130AbgHCUMg (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 3 Aug 2020 16:12:36 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 073K95NY195545;
        Mon, 3 Aug 2020 16:12:28 -0400
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0a-001b2d01.pphosted.com with ESMTP id 32pph8vhdp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 03 Aug 2020 16:12:27 -0400
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 073KCLRF006777;
        Mon, 3 Aug 2020 20:12:26 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma03fra.de.ibm.com with ESMTP id 32nyyd0r6b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 03 Aug 2020 20:12:26 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 073KCN0o11731392
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 3 Aug 2020 20:12:23 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B3EB9AE056;
        Mon,  3 Aug 2020 20:12:23 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 65197AE04D;
        Mon,  3 Aug 2020 20:12:23 +0000 (GMT)
Received: from osiris (unknown [9.171.25.113])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Mon,  3 Aug 2020 20:12:23 +0000 (GMT)
Date:   Mon, 3 Aug 2020 22:12:21 +0200
From:   Heiko Carstens <hca@linux.ibm.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Sven Schnelle <svens@linux.ibm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        linux-s390@vger.kernel.org
Subject: Re: [PATCH 2/2] s390: convert to GENERIC_VDSO
Message-ID: <20200803201221.GA6463@osiris>
References: <20200803055645.79042-1-svens@linux.ibm.com>
 <20200803055645.79042-3-svens@linux.ibm.com>
 <87ft93ncaa.fsf@nanos.tec.linutronix.de>
 <yt9dmu3b3jo3.fsf@linux.ibm.com>
 <87a6zbn29n.fsf@nanos.tec.linutronix.de>
 <20200803184428.GA3973@osiris>
 <873653mswn.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <873653mswn.fsf@nanos.tec.linutronix.de>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-03_15:2020-08-03,2020-08-03 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 priorityscore=1501 clxscore=1015 bulkscore=0 spamscore=0 impostorscore=0
 lowpriorityscore=0 mlxlogscore=544 suspectscore=1 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008030135
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Mon, Aug 03, 2020 at 09:27:36PM +0200, Thomas Gleixner wrote:
> Heiko Carstens <hca@linux.ibm.com> writes:
> 
> > On Mon, Aug 03, 2020 at 06:05:24PM +0200, Thomas Gleixner wrote:
> >> +/**
> >> + * vdso_update_begin - Start of a VDSO update section
> >> + *
> >> + * Allows architecture code to safely update the architecture specific VDSO
> >> + * data.
> >> + */
> >> +void vdso_update_begin(void)
> >> +{
> >> +	struct vdso_data *vdata = __arch_get_k_vdso_data();
> >> +
> >> +	raw_spin_lock(&timekeeper_lock);
> >> +	vdso_write_begin(vdata);
> >> +}
> >
> > I would assume that this only works if vdso_update_begin() is called
> > with irqs disabled, otherwise it could deadlock, no?
> 
> Yes.
> 
> > Maybe something like:
> >
> > void vdso_update_begin(unsigned long *flags)
> > {
> > 	struct vdso_data *vdata = __arch_get_k_vdso_data();
> >
> > 	raw_spin_lock_irqsave(&timekeeper_lock, *flags);
> > 	vdso_write_begin(vdata);
> 
> Shudder. Why not returning flags?

That was what I had initially but then looked at lock_timer_base(),
and tried to be consistent. Ok, bad example, since lock_timer_base()
cannot return flags.

> Thought about that briefly, but then hated the flags thing and delegated
> it to the caller. Lockdep will yell if that lock is taken with
> interrupts enabled :)
> 
> But aside of the pointer vs. value thing, I'm fine with doing it in the
> functions.

FWIW, my preference would also to use values instead of pointers.
