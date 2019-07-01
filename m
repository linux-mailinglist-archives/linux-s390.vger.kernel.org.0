Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C8AD84ED02
	for <lists+linux-s390@lfdr.de>; Fri, 21 Jun 2019 18:20:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726511AbfFUQTr (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Fri, 21 Jun 2019 12:19:47 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:59126 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726017AbfFUQTr (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Fri, 21 Jun 2019 12:19:47 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5LGCW41144009
        for <linux-s390@vger.kernel.org>; Fri, 21 Jun 2019 12:19:46 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2t8yb41gtj-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Fri, 21 Jun 2019 12:19:45 -0400
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <sebott@linux.ibm.com>;
        Fri, 21 Jun 2019 17:19:41 +0100
Received: from b06avi18878370.portsmouth.uk.ibm.com (9.149.26.194)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 21 Jun 2019 17:19:39 +0100
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x5LGJbw738601180
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 21 Jun 2019 16:19:37 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CD98011C05C;
        Fri, 21 Jun 2019 16:19:37 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3894811C054;
        Fri, 21 Jun 2019 16:19:37 +0000 (GMT)
Received: from sig-9-145-18-245.uk.ibm.com (unknown [9.145.18.245])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Fri, 21 Jun 2019 16:19:37 +0000 (GMT)
Date:   Fri, 21 Jun 2019 18:19:36 +0200 (CEST)
From:   Sebastian Ott <sebott@linux.ibm.com>
X-X-Sender: sebott@schleppi
To:     Cornelia Huck <cohuck@redhat.com>
cc:     Peter Oberparleiter <oberpar@linux.ibm.com>,
        Halil Pasic <pasic@linux.ibm.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] s390/cio: introduce driver_override on the css bus
In-Reply-To: <20190613110815.17251-1-cohuck@redhat.com>
References: <20190613110815.17251-1-cohuck@redhat.com>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
Organization: =?ISO-8859-15?Q?=22IBM_Deutschland_Research_&_Development_GmbH?=
 =?ISO-8859-15?Q?_=2F_Vorsitzende_des_Aufsichtsrats=3A_Matthias?=
 =?ISO-8859-15?Q?_Hartmann_Gesch=E4ftsf=FChrung=3A_Dirk_Wittkopp?=
 =?ISO-8859-15?Q?_Sitz_der_Gesellschaft=3A_B=F6blingen_=2F_Reg?=
 =?ISO-8859-15?Q?istergericht=3A_Amtsgericht_Stuttgart=2C_HRB_2432?=
 =?ISO-8859-15?Q?94=22?=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-TM-AS-GCONF: 00
x-cbid: 19062116-0020-0000-0000-0000034C3EC4
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19062116-0021-0000-0000-0000219FA048
Message-Id: <alpine.LFD.2.21.1906211817010.2388@schleppi>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-21_11:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=3 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=871 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906210131
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Thu, 13 Jun 2019, Cornelia Huck wrote:
> Sometimes, we want to control which of the matching drivers
> binds to a subchannel device (e.g. for subchannels we want to
> handle via vfio-ccw).
> 
> For pci devices, a mechanism to do so has been introduced in
> 782a985d7af2 ("PCI: Introduce new device binding path using
> pci_dev.driver_override"). It makes sense to introduce the
> driver_override attribute for subchannel devices as well, so
> that we can easily extend the 'driverctl' tool (which makes
> use of the driver_override attribute for pci).
> 
> Note that unlike pci we still require a driver override to
> match the subchannel type; matching more than one subchannel
> type is probably not useful anyway.
> 
> Signed-off-by: Cornelia Huck <cohuck@redhat.com>

Reviewed-by: Sebastian Ott <sebott@linux.ibm.com>

Should I take that via our git tree or do you have other patches depending 
on this one?

