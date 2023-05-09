Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5045E6FC556
	for <lists+linux-s390@lfdr.de>; Tue,  9 May 2023 13:49:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235178AbjEILtA (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Tue, 9 May 2023 07:49:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235526AbjEILsz (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 9 May 2023 07:48:55 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCE2A40F8;
        Tue,  9 May 2023 04:48:52 -0700 (PDT)
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 349ApO2o021181;
        Tue, 9 May 2023 11:48:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=pp1;
 bh=OVfvtwfXFMQ670LKiZAKPIpUOndUmSM+K62GcEHPiBY=;
 b=jL6pPnNc2qFinivLkWmVia6acfxiw6JEotmnWxaiCdL4eY37eEqc8wJlYK0w9NDTY0L1
 ZinFbiL0pj2+YiSabFo03gycXXc6VEvOeHb2aQ+O/yTN7Q92nqkHvvd3+q1R4PDI8Z1z
 B/4b6DUBkmxGNIx5nnbnaxsS0sApOwoz0zIaT1wg7dl68wCb5awtrQi5SW1M/w+23qo+
 YA4TGisOdHnbFC6sN84xytl4TsSyrA/jMfpK8v9zxUoaxM6Wvf2Ff3tJxaubzqZJrvub
 hwHbZjiXPt1m0U1GoP7c15LPi/z3d+CrEAuKcppVJTcBST7NC94T6/0C40hyPerDwrvF VA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3qfmb32527-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 09 May 2023 11:48:52 +0000
Received: from m0353727.ppops.net (m0353727.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 349BZ0Rc000742;
        Tue, 9 May 2023 11:48:51 GMT
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3qfmb3250s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 09 May 2023 11:48:51 +0000
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 349BYnVg013410;
        Tue, 9 May 2023 11:48:49 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
        by ppma02fra.de.ibm.com (PPS) with ESMTPS id 3qf7dg0bcm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 09 May 2023 11:48:49 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
        by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 349BmjnY54788540
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 9 May 2023 11:48:46 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D32732004B;
        Tue,  9 May 2023 11:48:45 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A61832004E;
        Tue,  9 May 2023 11:48:45 +0000 (GMT)
Received: from p-imbrenda (unknown [9.152.224.56])
        by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Tue,  9 May 2023 11:48:45 +0000 (GMT)
Date:   Tue, 9 May 2023 13:43:51 +0200
From:   Claudio Imbrenda <imbrenda@linux.ibm.com>
To:     Nico Boehr <nrb@linux.ibm.com>
Cc:     borntraeger@linux.ibm.com, frankja@linux.ibm.com, david@redhat.com,
        kvm@vger.kernel.org, linux-s390@vger.kernel.org
Subject: Re: [PATCH v1 2/3] KVM: s390: add stat counter for shadow gmap
 events
Message-ID: <20230509134351.1ac4ea63@p-imbrenda>
In-Reply-To: <20230509111202.333714-3-nrb@linux.ibm.com>
References: <20230509111202.333714-1-nrb@linux.ibm.com>
        <20230509111202.333714-3-nrb@linux.ibm.com>
Organization: IBM
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: N9ZoEsdEBImqjsIaivPCidW2XhIKYdQI
X-Proofpoint-GUID: njyzSoJo_5PnMUsSQ4xoWg7C_zAGmX0F
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-09_07,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0 mlxscore=0
 priorityscore=1501 phishscore=0 suspectscore=0 bulkscore=0 adultscore=0
 mlxlogscore=999 clxscore=1015 spamscore=0 malwarescore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2305090092
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Tue,  9 May 2023 13:12:01 +0200
Nico Boehr <nrb@linux.ibm.com> wrote:

> The shadow gmap tracks memory of nested guests (guest-3). In certain
> scenarios, the shadow gmap needs to be rebuilt, which is a costly operation
> since it involves a SIE exit into guest-1 for every entry in the respective
> shadow level.
> 
> Add kvm stat counters when new shadow structures are created at various
> levels. Also add a counter gmap_shadow_acquire when a completely fresh
> shadow gmap is created.
> 
> Note that there is no counter for the region first level. This is because
> the region first level is the highest level and hence is never referenced
> by another table. Creating a new region first table is therefore always
> equivalent to a new shadow gmap and hence is counted as
> gmap_shadow_acquire.
> 
> Also note that not all page table levels need to be present and a ASCE
> can directly point to e.g. a segment table. In this case, a new segment
> table will always be equivalent to a new shadow gmap and hence will be
> counted as gmap_shadow_acquire and not as gmap_shadow_segment.
> 
> Signed-off-by: Nico Boehr <nrb@linux.ibm.com>

looks good, see a nit below

> ---
>  arch/s390/include/asm/kvm_host.h | 5 +++++
>  arch/s390/kvm/gaccess.c          | 6 ++++++
>  arch/s390/kvm/kvm-s390.c         | 7 ++++++-
>  arch/s390/kvm/vsie.c             | 1 +
>  4 files changed, 18 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/s390/include/asm/kvm_host.h b/arch/s390/include/asm/kvm_host.h
> index 3c3fe45085ec..7f70e3bbb44c 100644
> --- a/arch/s390/include/asm/kvm_host.h
> +++ b/arch/s390/include/asm/kvm_host.h
> @@ -777,6 +777,11 @@ struct kvm_vm_stat {
>  	u64 inject_service_signal;
>  	u64 inject_virtio;
>  	u64 aen_forward;
> +	u64 gmap_shadow_acquire;
> +	u64 gmap_shadow_r2;
> +	u64 gmap_shadow_r3;
> +	u64 gmap_shadow_segment;
> +	u64 gmap_shadow_page;
>  };
>  
>  struct kvm_arch_memory_slot {
> diff --git a/arch/s390/kvm/gaccess.c b/arch/s390/kvm/gaccess.c
> index 3eb85f254881..8348a0095f3a 100644
> --- a/arch/s390/kvm/gaccess.c
> +++ b/arch/s390/kvm/gaccess.c
> @@ -1382,6 +1382,7 @@ static int kvm_s390_shadow_tables(struct gmap *sg, unsigned long saddr,
>  				  unsigned long *pgt, int *dat_protection,
>  				  int *fake)
>  {
> +	struct kvm *kvm;
>  	struct gmap *parent;
>  	union asce asce;
>  	union vaddress vaddr;
> @@ -1390,6 +1391,7 @@ static int kvm_s390_shadow_tables(struct gmap *sg, unsigned long saddr,
>  
>  	*fake = 0;
>  	*dat_protection = 0;
> +	kvm = sg->private;
>  	parent = sg->parent;
>  	vaddr.addr = saddr;
>  	asce.val = sg->orig_asce;
> @@ -1450,6 +1452,7 @@ static int kvm_s390_shadow_tables(struct gmap *sg, unsigned long saddr,
>  		rc = gmap_shadow_r2t(sg, saddr, rfte.val, *fake);
>  		if (rc)
>  			return rc;
> +		kvm->stat.gmap_shadow_r2++;
>  	}
>  		fallthrough;
>  	case ASCE_TYPE_REGION2: {
> @@ -1478,6 +1481,7 @@ static int kvm_s390_shadow_tables(struct gmap *sg, unsigned long saddr,
>  		rc = gmap_shadow_r3t(sg, saddr, rste.val, *fake);
>  		if (rc)
>  			return rc;
> +		kvm->stat.gmap_shadow_r3++;
>  	}
>  		fallthrough;
>  	case ASCE_TYPE_REGION3: {
> @@ -1515,6 +1519,7 @@ static int kvm_s390_shadow_tables(struct gmap *sg, unsigned long saddr,
>  		rc = gmap_shadow_sgt(sg, saddr, rtte.val, *fake);
>  		if (rc)
>  			return rc;
> +		kvm->stat.gmap_shadow_segment++;
>  	}
>  		fallthrough;
>  	case ASCE_TYPE_SEGMENT: {
> @@ -1548,6 +1553,7 @@ static int kvm_s390_shadow_tables(struct gmap *sg, unsigned long saddr,
>  		rc = gmap_shadow_pgt(sg, saddr, ste.val, *fake);
>  		if (rc)
>  			return rc;
> +		kvm->stat.gmap_shadow_page++;

do I understand correctly that, if several levels need to be shadowed
at the same time, you will increment every affected counter, and not
just the highest or lowest level?

if so, please add a brief explanation to the patch description

>  	}
>  	}
>  	/* Return the parent address of the page table */
> diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
> index 17b81659cdb2..b012645a5a7c 100644
> --- a/arch/s390/kvm/kvm-s390.c
> +++ b/arch/s390/kvm/kvm-s390.c
> @@ -66,7 +66,12 @@ const struct _kvm_stats_desc kvm_vm_stats_desc[] = {
>  	STATS_DESC_COUNTER(VM, inject_pfault_done),
>  	STATS_DESC_COUNTER(VM, inject_service_signal),
>  	STATS_DESC_COUNTER(VM, inject_virtio),
> -	STATS_DESC_COUNTER(VM, aen_forward)
> +	STATS_DESC_COUNTER(VM, aen_forward),
> +	STATS_DESC_COUNTER(VM, gmap_shadow_acquire),
> +	STATS_DESC_COUNTER(VM, gmap_shadow_r2),
> +	STATS_DESC_COUNTER(VM, gmap_shadow_r3),
> +	STATS_DESC_COUNTER(VM, gmap_shadow_segment),
> +	STATS_DESC_COUNTER(VM, gmap_shadow_page),
>  };
>  
>  const struct kvm_stats_header kvm_vm_stats_header = {
> diff --git a/arch/s390/kvm/vsie.c b/arch/s390/kvm/vsie.c
> index 8d6b765abf29..beb3be037722 100644
> --- a/arch/s390/kvm/vsie.c
> +++ b/arch/s390/kvm/vsie.c
> @@ -1221,6 +1221,7 @@ static int acquire_gmap_shadow(struct kvm_vcpu *vcpu,
>  	if (IS_ERR(gmap))
>  		return PTR_ERR(gmap);
>  	gmap->private = vcpu->kvm;
> +	vcpu->kvm->stat.gmap_shadow_acquire++;
>  	WRITE_ONCE(vsie_page->gmap, gmap);
>  	return 0;
>  }

