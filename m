Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F4F444DBEE
	for <lists+linux-s390@lfdr.de>; Thu, 11 Nov 2021 20:05:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233793AbhKKTIb (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Thu, 11 Nov 2021 14:08:31 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:2562 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232411AbhKKTIb (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 11 Nov 2021 14:08:31 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1ABH0NJa030970;
        Thu, 11 Nov 2021 19:05:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=K+hVt+CKf4OssH9jEI3HlNuwQBAj975n0xaJV3m9/fU=;
 b=MT81+vQTYAKRqYw+usCzt199FEwN9SgZfdVeOVV09HuXd1gIm4ztb41NKv6fXmqTh9vG
 ynF5B0fEaGcl9k3wT7PioW/kgJxxqDG95uQuPV6NtW+naPRvACcfMYUXX0x+JUzeK5DX
 OKnUsE3njlO/5Xn+6R9GfRcBn85GRXII2fyOX74zs2V7tm4fBBzu7nVpDUNinK6ovV8m
 RqcSJyRvvNb96BAINJX9PtpHxa0FYjaAybU5sSDTN2AGZYw0qvoUKFZ4iYZ/vghwt7GI
 36l+nq7A34NGyKpK7Rdl3YcVG/Q55sxDLqXsoDzREbQeRXkR9IIlR2dUBAxizcavHcNk Vg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3c955gxnag-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 11 Nov 2021 19:05:40 +0000
Received: from m0098396.ppops.net (m0098396.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1ABIC6ia024486;
        Thu, 11 Nov 2021 19:05:40 GMT
Received: from ppma03wdc.us.ibm.com (ba.79.3fa9.ip4.static.sl-reverse.com [169.63.121.186])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3c955gxn9w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 11 Nov 2021 19:05:40 +0000
Received: from pps.filterd (ppma03wdc.us.ibm.com [127.0.0.1])
        by ppma03wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1ABJ4giX029867;
        Thu, 11 Nov 2021 19:05:39 GMT
Received: from b03cxnp07028.gho.boulder.ibm.com (b03cxnp07028.gho.boulder.ibm.com [9.17.130.15])
        by ppma03wdc.us.ibm.com with ESMTP id 3c5hbd3tga-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 11 Nov 2021 19:05:39 +0000
Received: from b03ledav003.gho.boulder.ibm.com (b03ledav003.gho.boulder.ibm.com [9.17.130.234])
        by b03cxnp07028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1ABJ5b7S30081726
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 11 Nov 2021 19:05:37 GMT
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B271A6A05F;
        Thu, 11 Nov 2021 19:05:37 +0000 (GMT)
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BB1A26A047;
        Thu, 11 Nov 2021 19:05:36 +0000 (GMT)
Received: from farman-thinkpad-t470p (unknown [9.211.106.148])
        by b03ledav003.gho.boulder.ibm.com (Postfix) with ESMTP;
        Thu, 11 Nov 2021 19:05:36 +0000 (GMT)
Message-ID: <19a2543b24015873db736bddb14d0e4d97712086.camel@linux.ibm.com>
Subject: Re: [RFC PATCH v3 2/2] KVM: s390: Extend the USER_SIGP capability
From:   Eric Farman <farman@linux.ibm.com>
To:     David Hildenbrand <david@redhat.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Thomas Huth <thuth@redhat.com>
Cc:     Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>, kvm@vger.kernel.org,
        linux-s390@vger.kernel.org
Date:   Thu, 11 Nov 2021 14:05:35 -0500
In-Reply-To: <85ba9fa3-ca25-b598-aecd-5e0c6a0308f2@redhat.com>
References: <20211110203322.1374925-1-farman@linux.ibm.com>
         <20211110203322.1374925-3-farman@linux.ibm.com>
         <dd8a8b49-da6d-0ab8-dc47-b24f5604767f@redhat.com>
         <ab82e68051674ea771e2cb5371ca2a204effab40.camel@linux.ibm.com>
         <32836eb5-532f-962d-161a-faa2213a0691@linux.ibm.com>
         <b116e738d8f9b185867ab28395012aaddd58af31.camel@linux.ibm.com>
         <85ba9fa3-ca25-b598-aecd-5e0c6a0308f2@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-16.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: tmV6IxcfVatlRe0I3janGZF93l3tTYgY
X-Proofpoint-ORIG-GUID: tXZ7B2PWodQA_HJtM9TEw02KsxYT3MT-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-11_06,2021-11-11_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 suspectscore=0 spamscore=0 impostorscore=0 adultscore=0 mlxscore=0
 phishscore=0 mlxlogscore=999 clxscore=1015 bulkscore=0 malwarescore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2111110100
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Thu, 2021-11-11 at 19:29 +0100, David Hildenbrand wrote:
> On 11.11.21 18:48, Eric Farman wrote:
> > On Thu, 2021-11-11 at 17:13 +0100, Janosch Frank wrote:
> > > On 11/11/21 16:03, Eric Farman wrote:
> > > > On Thu, 2021-11-11 at 10:15 +0100, David Hildenbrand wrote:
> > > > > On 10.11.21 21:33, Eric Farman wrote:
> > > > > > With commit 2444b352c3ac ("KVM: s390: forward most SIGP
> > > > > > orders
> > > > > > to
> > > > > > user
> > > > > > space") we have a capability that allows the "fast" SIGP
> > > > > > orders
> > > > > > (as
> > > > > > defined by the Programming Notes for the SIGNAL PROCESSOR
> > > > > > instruction in
> > > > > > the Principles of Operation) to be handled in-kernel, while
> > > > > > all
> > > > > > others are
> > > > > > sent to userspace for processing.
> > > > > > 
> > > > > > This works fine but it creates a situation when, for
> > > > > > example, a
> > > > > > SIGP SENSE
> > > > > > might return CC1 (STATUS STORED, and status bits indicating
> > > > > > the
> > > > > > vcpu is
> > > > > > stopped), when in actuality userspace is still processing a
> > > > > > SIGP
> > > > > > STOP AND
> > > > > > STORE STATUS order, and the vcpu is not yet actually
> > > > > > stopped.
> > > > > > Thus,
> > > > > > the
> > > > > > SIGP SENSE should actually be returning CC2 (busy) instead
> > > > > > of
> > > > > > CC1.
> > > > > > 
> > > > > > To fix this, add another CPU capability, dependent on the
> > > > > > USER_SIGP
> > > > > > one,
> > > > > > and two associated IOCTLs. One IOCTL will be used by
> > > > > > userspace
> > > > > > to
> > > > > > mark a
> > > > > > vcpu "busy" processing a SIGP order, and cause concurrent
> > > > > > orders
> > > > > > handled
> > > > > > in-kernel to be returned with CC2 (busy). Another IOCTL
> > > > > > will be
> > > > > > used by
> > > > > > userspace to mark the SIGP "finished", and the vcpu free to
> > > > > > process
> > > > > > additional orders.
> > > > > > 
> > > > > 
> > > > > This looks much cleaner to me, thanks!
> > > > > 
> > > > > [...]
> > > > > 
> > > > > > diff --git a/arch/s390/kvm/kvm-s390.h b/arch/s390/kvm/kvm-
> > > > > > s390.h
> > > > > > index c07a050d757d..54371cede485 100644
> > > > > > --- a/arch/s390/kvm/kvm-s390.h
> > > > > > +++ b/arch/s390/kvm/kvm-s390.h
> > > > > > @@ -82,6 +82,22 @@ static inline int is_vcpu_idle(struct
> > > > > > kvm_vcpu
> > > > > > *vcpu)
> > > > > >   	return test_bit(vcpu->vcpu_idx, vcpu->kvm-
> > > > > > > arch.idle_mask);
> > > > > >   }
> > > > > >   
> > > > > > +static inline bool kvm_s390_vcpu_is_sigp_busy(struct
> > > > > > kvm_vcpu
> > > > > > *vcpu)
> > > > > > +{
> > > > > > +	return (atomic_read(&vcpu->arch.sigp_busy) == 1);
> > > > > 
> > > > > You can drop ()
> > > > > 
> > > > > > +}
> > > > > > +
> > > > > > +static inline bool kvm_s390_vcpu_set_sigp_busy(struct
> > > > > > kvm_vcpu
> > > > > > *vcpu)
> > > > > > +{
> > > > > > +	/* Return zero for success, or -EBUSY if another vcpu
> > > > > > won */
> > > > > > +	return (atomic_cmpxchg(&vcpu->arch.sigp_busy, 0, 1) ==
> > > > > > 0) ? 0 :
> > > > > > -EBUSY;
> > > > > 
> > > > > You can drop () as well.
> > > > > 
> > > > > We might not need the -EBUSY semantics after all. User space
> > > > > can
> > > > > just
> > > > > track if it was set, because it's in charge of setting it.
> > > > 
> > > > Hrm, I added this to distinguish a newer kernel with an older
> > > > QEMU,
> > > > but
> > > > of course an older QEMU won't know the difference either. I'll
> > > > doublecheck that this is works fine in the different
> > > > permutations.
> > > > 
> > > > > > +}
> > > > > > +
> > > > > > +static inline void kvm_s390_vcpu_clear_sigp_busy(struct
> > > > > > kvm_vcpu
> > > > > > *vcpu)
> > > > > > +{
> > > > > > +	atomic_set(&vcpu->arch.sigp_busy, 0);
> > > > > > +}
> > > > > > +
> > > > > >   static inline int kvm_is_ucontrol(struct kvm *kvm)
> > > > > >   {
> > > > > >   #ifdef CONFIG_KVM_S390_UCONTROL
> > > > > > diff --git a/arch/s390/kvm/sigp.c b/arch/s390/kvm/sigp.c
> > > > > > index 5ad3fb4619f1..a37496ea6dfa 100644
> > > > > > --- a/arch/s390/kvm/sigp.c
> > > > > > +++ b/arch/s390/kvm/sigp.c
> > > > > > @@ -276,6 +276,10 @@ static int handle_sigp_dst(struct
> > > > > > kvm_vcpu
> > > > > > *vcpu, u8 order_code,
> > > > > >   	if (!dst_vcpu)
> > > > > >   		return SIGP_CC_NOT_OPERATIONAL;
> > > > > >   
> > > > > > +	if (kvm_s390_vcpu_is_sigp_busy(dst_vcpu)) {
> > > > > > +		return SIGP_CC_BUSY;
> > > > > > +	}
> > > > > 
> > > > > You can drop {}
> > > > 
> > > > Arg, I had some debug in there which needed the braces, and of
> > > > course
> > > > it's unnecessary now. Thanks.
> > > > 
> > > > > > +
> > > > > >   	switch (order_code) {
> > > > > >   	case SIGP_SENSE:
> > > > > >   		vcpu->stat.instruction_sigp_sense++;
> > > > > > @@ -411,6 +415,12 @@ int kvm_s390_handle_sigp(struct
> > > > > > kvm_vcpu
> > > > > > *vcpu)
> > > > > >   	if (handle_sigp_order_in_user_space(vcpu, order_code,
> > > > > > cpu_addr))
> > > > > >   		return -EOPNOTSUPP;
> > > > > >   
> > > > > > +	/* Check the current vcpu, if it was a target from
> > > > > > another vcpu
> > > > > > */
> > > > > > +	if (kvm_s390_vcpu_is_sigp_busy(vcpu)) {
> > > > > > +		kvm_s390_set_psw_cc(vcpu, SIGP_CC_BUSY);
> > > > > > +		return 0;
> > > > > > +	}
> > > > > 
> > > > > I don't think we need this. I think the above (checking the
> > > > > target of
> > > > > a
> > > > > SIGP order) is sufficient. Or which situation do you have in
> > > > > mind?
> > > > > 
> > > > 
> > > > Hrm... I think you're right. I was thinking of this:
> > > > 
> > > > VCPU 1 - SIGP STOP CPU 2
> > > > VCPU 2 - SIGP SENSE CPU 1
> > > > 
> > > > But of course either CPU2 is going to be marked "busy" first,
> > > > and
> > > > the
> > > > sense doesn't get processed until it's reset, or the sense
> > > > arrives
> > > > first, and the busy/notbusy doesn't matter. Let me doublecheck
> > > > my
> > > > tests
> > > > for the non-RFC version.
> > > > 
> > > > > I do wonder if we want to make this a kvm_arch_vcpu_ioctl()
> > > > > instead,
> > > > 
> > > > In one of my original attempts between v1 and v2, I had put
> > > > this
> > > > there.
> > > > This reliably deadlocks my guest, because the caller
> > > > (kvm_vcpu_ioctl())
> > > > tries to acquire vcpu->mutex, and racing SIGPs (via KVM_RUN)
> > > > might
> > > > already be holding it. Thus, it's an async ioctl. I could fold
> > > > it
> > > > into
> > > > the existing interrupt ioctl, but as those are architected
> > > > structs
> > > > it
> > > > seems more natural do it this way. Or I have mis-understood
> > > > something
> > > > along the way?
> > > > 
> > > > > essentially just providing a KVM_S390_SET_SIGP_BUSY *and*
> > > > > providing
> > > > > the
> > > > > order. "order == 0" sets it to !busy.
> > > > 
> > > > I'd tried this too, since it provided some nice debug-ability.
> > > > Unfortunately, I have a testcase (which I'll eventually get
> > > > folded
> > > > into
> > > > kvm-unit-tests :)) that picks a random order between 0-255,
> > > > knowing
> > > > that there's only a couple handfuls of valid orders, to check
> > > > the
> > > > response. Zero is valid architecturally (POPS figure 4-29),
> > > > even if
> > > > it's unassigned. The likelihood of it becoming assigned is
> > > > probably
> > > > quite low, but I'm not sure that I like special-casing an order
> > > > of
> > > > zero
> > > > in this way.
> > > > 
> > > 
> > > Looking at the API I'd like to avoid having two IOCTLs 
> > 
> > Since the order is a single byte, we could have the payload of an
> > ioctl
> > say "0-255 is an order that we're busy processing, anything higher
> > than
> > that resets the busy" or something. That would remove the need for
> > a
> > second IOCTL.
> 
> Maybe just pass an int and treat a negative (or just -1) value as
> clearing the order.
> 

Right, that's exactly what I had at one point. I thought it was too
cumbersome, but maybe not. Will dust it off, pending my question to
Janosch about 0-vs-1 IOCTLs.


