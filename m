Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD7E123AC90
	for <lists+linux-s390@lfdr.de>; Mon,  3 Aug 2020 20:44:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728742AbgHCSop (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Mon, 3 Aug 2020 14:44:45 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:60358 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728515AbgHCSoo (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 3 Aug 2020 14:44:44 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 073Ib0ZV174990;
        Mon, 3 Aug 2020 14:44:34 -0400
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 32pqdhh08t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 03 Aug 2020 14:44:34 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 073IZZvK021220;
        Mon, 3 Aug 2020 18:44:32 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma04ams.nl.ibm.com with ESMTP id 32n0182fgb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 03 Aug 2020 18:44:32 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 073IiU6Q28901674
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 3 Aug 2020 18:44:30 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id ED73E11C050;
        Mon,  3 Aug 2020 18:44:29 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A5C0C11C04C;
        Mon,  3 Aug 2020 18:44:29 +0000 (GMT)
Received: from osiris (unknown [9.171.25.113])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Mon,  3 Aug 2020 18:44:29 +0000 (GMT)
Date:   Mon, 3 Aug 2020 20:44:28 +0200
From:   Heiko Carstens <hca@linux.ibm.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Sven Schnelle <svens@linux.ibm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        linux-s390@vger.kernel.org
Subject: Re: [PATCH 2/2] s390: convert to GENERIC_VDSO
Message-ID: <20200803184428.GA3973@osiris>
References: <20200803055645.79042-1-svens@linux.ibm.com>
 <20200803055645.79042-3-svens@linux.ibm.com>
 <87ft93ncaa.fsf@nanos.tec.linutronix.de>
 <yt9dmu3b3jo3.fsf@linux.ibm.com>
 <87a6zbn29n.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87a6zbn29n.fsf@nanos.tec.linutronix.de>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-03_15:2020-08-03,2020-08-03 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 mlxscore=0
 bulkscore=0 impostorscore=0 mlxlogscore=772 priorityscore=1501
 clxscore=1011 suspectscore=1 phishscore=0 spamscore=0 lowpriorityscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008030130
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Mon, Aug 03, 2020 at 06:05:24PM +0200, Thomas Gleixner wrote:
> +/**
> + * vdso_update_begin - Start of a VDSO update section
> + *
> + * Allows architecture code to safely update the architecture specific VDSO
> + * data.
> + */
> +void vdso_update_begin(void)
> +{
> +	struct vdso_data *vdata = __arch_get_k_vdso_data();
> +
> +	raw_spin_lock(&timekeeper_lock);
> +	vdso_write_begin(vdata);
> +}

I would assume that this only works if vdso_update_begin() is called
with irqs disabled, otherwise it could deadlock, no?

Maybe something like:

void vdso_update_begin(unsigned long *flags)
{
	struct vdso_data *vdata = __arch_get_k_vdso_data();

	raw_spin_lock_irqsave(&timekeeper_lock, *flags);
	vdso_write_begin(vdata);
}

void vdso_update_end(unsigned long *flags)
{
	struct vdso_data *vdata = __arch_get_k_vdso_data();

	vdso_write_end(vdata);
	__arch_sync_vdso_data(vdata);
	raw_spin_unlock_irqrestore(&timekeeper_lock, *flags);
}

? Just wondering.
