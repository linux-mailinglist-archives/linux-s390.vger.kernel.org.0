Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17E662F52C2
	for <lists+linux-s390@lfdr.de>; Wed, 13 Jan 2021 19:57:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728341AbhAMSzn (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Wed, 13 Jan 2021 13:55:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:44684 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728328AbhAMSzn (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Wed, 13 Jan 2021 13:55:43 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 644E32222B;
        Wed, 13 Jan 2021 18:55:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610564102;
        bh=yuHsL79Rd3202Hi/UJQF2BDz8BRxCYQuw84DSpJYcDM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=UsUMq6YOXYcOu6I4d3KphnjPuEzQGMmMHeCifzbpDARasRxk4mAo64ZTqQA4Ml6FR
         EphaTP+Ij6RI0+FrIywMXGIbbx4ucGUg07K64nOzp4LwIJz5dJreO8qH8UR+GXttTQ
         CwdPgg0ZdTs6wXD52cZNNuUy+XUziKZf37i9CZcAVQKi7QeaP+SvM6PpD7ey4o1B7E
         KHktYPP4zp/gqzP3bTIRDfUVaWQOBSRSOmUoMrAH8iONdbDdSbSg7ohmDVXTfCqEH+
         HU3xKBwzcKJX/DWX5NYJzGt/5fH6JDLoq55Hz+lyx08LfYYliM/C22f8OwT9Ge9q1X
         Qe5l2AYkCmWkw==
Date:   Wed, 13 Jan 2021 12:55:00 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Niklas Schnelle <schnelle@linux.ibm.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org, Pierre Morel <pmorel@linux.ibm.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Viktor Mihajlovski <mihajlov@linux.ibm.com>
Subject: Re: [RFC 1/1] s390/pci: expose UID checking state in sysfs
Message-ID: <20210113185500.GA1918216@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4f5013a1-3dde-1633-a0cc-591fc439e29d@linux.ibm.com>
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Wed, Jan 13, 2021 at 08:47:58AM +0100, Niklas Schnelle wrote:
> On 1/12/21 10:50 PM, Bjorn Helgaas wrote:
> > On Mon, Jan 11, 2021 at 10:38:57AM +0100, Niklas Schnelle wrote:
> >> We use the UID of a zPCI adapter, or the UID of the function zero if
> >> there are multiple functions in an adapter, as PCI domain if and only if
> >> UID Checking is turned on.
> >> Otherwise we automatically generate domains as devices appear.
> >>
> >> The state of UID Checking is thus essential to know if the PCI domain
> >> will be stable, yet currently there is no way to access this information
> >> from userspace.
> >> So let's solve this by showing the state of UID checking as a sysfs
> >> attribute in /sys/bus/pci/uid_checking

> >> +/* Global zPCI attributes */
> >> +static ssize_t uid_checking_show(struct kobject *kobj,
> >> +				 struct kobj_attribute *attr, char *buf)
> >> +{
> >> +	return sprintf(buf, "%i\n", zpci_unique_uid);
> >> +}
> >> +
> >> +static struct kobj_attribute sys_zpci_uid_checking_attr =
> >> +	__ATTR(uid_checking, 0444, uid_checking_show, NULL);
> > 
> > Use DEVICE_ATTR_RO instead of __ATTR.
> 
> It's my understanding that DEVICE_ATTR_* is only for
> per device attributes. This one is global for the entire
> Z PCI. I just tried with BUS_ATTR_RO instead
> and that works but only if I put the attribute at
> /sys/bus/pci/uid_checking instead of with a zpci
> subfolder. This path would work for us too, we
> currently don't have any other global attributes
> that we are planning to expose but those could of
> course come up in the future.

Ah, I missed the fact that this is a kobj_attribute, not a
device_attribute.  Maybe KERNEL_ATTR_RO()?  Very few uses so far, but
seems like it might fit?

Bjorn
