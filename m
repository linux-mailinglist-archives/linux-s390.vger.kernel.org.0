Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A656C1709D5
	for <lists+linux-s390@lfdr.de>; Wed, 26 Feb 2020 21:36:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727310AbgBZUgc (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Wed, 26 Feb 2020 15:36:32 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:60586 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727312AbgBZUgb (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 26 Feb 2020 15:36:31 -0500
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01QKP7FD143212
        for <linux-s390@vger.kernel.org>; Wed, 26 Feb 2020 15:36:30 -0500
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2ydqbt2g6w-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Wed, 26 Feb 2020 15:36:29 -0500
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <zohar@linux.ibm.com>;
        Wed, 26 Feb 2020 20:36:27 -0000
Received: from b06avi18878370.portsmouth.uk.ibm.com (9.149.26.194)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 26 Feb 2020 20:36:23 -0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 01QKaLJj47448484
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 Feb 2020 20:36:21 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9F3B642042;
        Wed, 26 Feb 2020 20:36:21 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 62F7D42047;
        Wed, 26 Feb 2020 20:36:20 +0000 (GMT)
Received: from dhcp-9-31-102-24.watson.ibm.com (unknown [9.31.102.24])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 26 Feb 2020 20:36:20 +0000 (GMT)
Subject: Re: [PATCH] ima: add a new CONFIG for loading arch-specific policies
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        Nayna Jain <nayna@linux.ibm.com>,
        linux-integrity@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-efi@vger.kernel.org, linux-s390@vger.kernel.org
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Philipp Rudo <prudo@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linux-kernel@vger.kernel.org
Date:   Wed, 26 Feb 2020 15:36:19 -0500
In-Reply-To: <94fe39a9-db9e-211d-d9b7-4cfe1a270e6f@linux.microsoft.com>
References: <1582744207-25969-1-git-send-email-nayna@linux.ibm.com>
         <94fe39a9-db9e-211d-d9b7-4cfe1a270e6f@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 20022620-4275-0000-0000-000003A5C3E1
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20022620-4276-0000-0000-000038B9E0AE
Message-Id: <1582749379.10443.246.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-26_07:2020-02-26,2020-02-26 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 phishscore=0
 impostorscore=0 suspectscore=3 adultscore=0 mlxscore=0 mlxlogscore=885
 clxscore=1011 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2001150001 definitions=main-2002260122
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Wed, 2020-02-26 at 11:21 -0800, Lakshmi Ramasubramanian wrote:
> Hi Nayna,
> 
> > +
> > +config IMA_SECURE_AND_OR_TRUSTED_BOOT
> > +	bool
> > +	depends on IMA
> > +	depends on IMA_ARCH_POLICY
> > +	default n
> > +	help
> > +	   This option is selected by architectures to enable secure and/or
> > +	   trusted boot based on IMA runtime policies.
> > 
> 
> Why is the default for this new config "n"?
> Is there any reason to not turn on this config if both IMA and 
> IMA_ARCH_POLICY are set to y?

Good catch.  Having "IMA_SECURE_AND_OR_TRUSTED_BOOT" depend on
"IMA_ARCH_POLICY" doesn't make sense.  "IMA_ARCH_POLICY" needs to be
selected.

thanks,

Mimi

