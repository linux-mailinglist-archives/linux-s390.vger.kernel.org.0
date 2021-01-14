Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FB9C2F6586
	for <lists+linux-s390@lfdr.de>; Thu, 14 Jan 2021 17:15:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726076AbhANQPH (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Thu, 14 Jan 2021 11:15:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:44576 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725918AbhANQPH (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Thu, 14 Jan 2021 11:15:07 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id C42C2239EB;
        Thu, 14 Jan 2021 16:14:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1610640866;
        bh=6xX+JZ3eD7/Whv74i4bNA2VkhHl2m10fENZO3mqzgVo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Gj6OI2oPlZD/tTfqVYtRC69HoaY0dP0J80+mt5tUtZdd0AB5ghmxx7VZkTWclBkt4
         39nyETPm4MJiKouoxR7St2YGFxM6R+WCcriOo2mD6WYjBdL0lo8pdSrvbMHemeCV9Z
         RtR9u3DB7iGSj5e9m97jLAYsCjWAy86aF6kTo7qM=
Date:   Thu, 14 Jan 2021 17:14:23 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Niklas Schnelle <schnelle@linux.ibm.com>
Cc:     Christian Brauner <christian.brauner@ubuntu.com>,
        Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        Pierre Morel <pmorel@linux.ibm.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Viktor Mihajlovski <mihajlov@linux.ibm.com>
Subject: Re: [RFC 1/1] s390/pci: expose UID checking state in sysfs
Message-ID: <YABt38yz5BJ8gARG@kroah.com>
References: <20210113185500.GA1918216@bjorn-Precision-5520>
 <675aa466-59ea-cf8a-6eec-caa6478ba4cd@linux.ibm.com>
 <20210114134453.bkfik4zjt5ehz6d5@wittgenstein>
 <YABOHuejsuriwSPn@kroah.com>
 <a567c3d2-1dd2-6b33-8b1a-0a607b601ef8@linux.ibm.com>
 <YABgcnWPLJxYlWUR@kroah.com>
 <f63d5de5-6a31-8839-72ce-c6e937f91d4a@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f63d5de5-6a31-8839-72ce-c6e937f91d4a@linux.ibm.com>
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Thu, Jan 14, 2021 at 04:51:17PM +0100, Niklas Schnelle wrote:
> 
> 
> On 1/14/21 4:17 PM, Greg Kroah-Hartman wrote:
> > On Thu, Jan 14, 2021 at 04:06:11PM +0100, Niklas Schnelle wrote:
> >>
> >>
> >> On 1/14/21 2:58 PM, Greg Kroah-Hartman wrote:
> >>> On Thu, Jan 14, 2021 at 02:44:53PM +0100, Christian Brauner wrote:
> >>>> On Thu, Jan 14, 2021 at 02:20:10PM +0100, Niklas Schnelle wrote:
> >>>>>
> >>>>>
> >>>>> On 1/13/21 7:55 PM, Bjorn Helgaas wrote:
> >>>>>> On Wed, Jan 13, 2021 at 08:47:58AM +0100, Niklas Schnelle wrote:
> >>>>>>> On 1/12/21 10:50 PM, Bjorn Helgaas wrote:
> >>>>>>>> On Mon, Jan 11, 2021 at 10:38:57AM +0100, Niklas Schnelle wrote:
> >>>>>>>>> We use the UID of a zPCI adapter, or the UID of the function zero if
> >>>>>>>>> there are multiple functions in an adapter, as PCI domain if and only if
> >>>>>>>>> UID Checking is turned on.
> >>>>>>>>> Otherwise we automatically generate domains as devices appear.
> >>>>>>>>>
> >>>>>>>>> The state of UID Checking is thus essential to know if the PCI domain
> >>>>>>>>> will be stable, yet currently there is no way to access this information
> >>>>>>>>> from userspace.
> >>>>>>>>> So let's solve this by showing the state of UID checking as a sysfs
> >>>>>>>>> attribute in /sys/bus/pci/uid_checking
> >>>>>>
> >>>>>>>>> +/* Global zPCI attributes */
> >>>>>>>>> +static ssize_t uid_checking_show(struct kobject *kobj,
> >>>>>>>>> +				 struct kobj_attribute *attr, char *buf)
> >>>>>>>>> +{
> >>>>>>>>> +	return sprintf(buf, "%i\n", zpci_unique_uid);
> >>>>>>>>> +}
> >>>>>>>>> +
> >>>>>>>>> +static struct kobj_attribute sys_zpci_uid_checking_attr =
> >>>>>>>>> +	__ATTR(uid_checking, 0444, uid_checking_show, NULL);
> >>>>>>>>
> >>>>>>>> Use DEVICE_ATTR_RO instead of __ATTR.
> >>>>>>>
> >>>>>>> It's my understanding that DEVICE_ATTR_* is only for
> >>>>>>> per device attributes. This one is global for the entire
> >>>>>>> Z PCI. I just tried with BUS_ATTR_RO instead
> >>>>>>> and that works but only if I put the attribute at
> >>>>>>> /sys/bus/pci/uid_checking instead of with a zpci
> >>>>>>> subfolder. This path would work for us too, we
> >>>>>>> currently don't have any other global attributes
> >>>>>>> that we are planning to expose but those could of
> >>>>>>> course come up in the future.
> >>>>>>
> >>>>>> Ah, I missed the fact that this is a kobj_attribute, not a
> >>>>>> device_attribute.  Maybe KERNEL_ATTR_RO()?  Very few uses so far, but
> >>>>>> seems like it might fit?
> >>>>>>
> >>>>>> Bjorn
> >>>>>>
> >>>>>
> >>>>> KERNEL_ATTR_* is currently not exported in any header. After
> >>>>> adding it to include/linuc/sysfs.h it indeed works perfectly.
> >>>>> Adding Christian Brauner as suggested by get_maintainers for
> >>>>> their opinion. I'm of course willing to provide a patch
> >>>>
> >>>> Hey Niklas et al. :)
> >>>>
> >>>> I think this will need input from Greg. He should be best versed in
> >>>> sysfs attributes. The problem with KERNEL_ATTR_* to me seems that it's
> >>>> supposed to be kernel internal. Now, that might just be a matter of
> >>>> renaming the macro but let's see whether Greg has any better idea or
> >>>> more questions. :)
> >>>
> >>> The big question is, why are you needing this?
> >>>
> >>> No driver or driver subsystem should EVER be messing with a "raw"
> >>> kobject like this.  Just use the existing DEVICE_* macros instead
> >>> please.
> >>>
> >>> If you are using a raw kobject, please ask me how to do this properly,
> >>> as that is something that should NEVER show up in the /sys/devices/*
> >>> tree.  Otherwise userspace tools will break.
> >>>
> >>> thanks,
> >>>
> >>> greg k-h
> >>
> >> Hi Greg,
> >>
> >> this is for an architecture specific but global i.e. not device bound PCI
> >> attribute. That's why DEVICE_ATTR_* does not work. BUS_ATTR_* would work
> >> but only if we place the attribute directly under /sys/bus/pci/new_attr.
> > 
> > Then you are doing something wrong :)
> 
> That is very possible.
> 
> > 
> > Where _exactly_ are you wanting to put this attribute?
> 
> I'm trying for /sys/bus/pci/zpci/uid_checking, I'm using
> the below code and the attribute even shows up but reading
> it gives me two 0 bytes only.
> The relevant code is only a slight alteration of the original patch
> as follows:
> 
> static ssize_t uid_checking_show(struct bus_type *bus, char *buf)
> {
> 	return sprintf(buf, "%i\n", zpci_unique_uid);
> }
> static BUS_ATTR_RO(uid_checking);
> 
> static struct kset *zpci_global_kset;
> 
> static struct attribute *zpci_attrs_global[] = {
> 	&bus_attr_uid_checking.attr,
> 	NULL,
> };
> 
> static struct attribute_group zpci_attr_group_global = {
> 	.attrs = zpci_attrs_global,
> };

Name your attribute group, and then you do not have to mess with a
"raw" kobject like you are below:

> 
> int __init zpci_sysfs_init(void)
> {
> 	struct kset *pci_bus_kset;
> 
> 	pci_bus_kset = bus_get_kset(&pci_bus_type);
> 
> 	zpci_global_kset = kset_create_and_add("zpci", NULL, &pci_bus_kset->kobj);

No, do not mess with at kset, just set the default attribute group for
the bus to the above, and you should be fine.

> 	if (!zpci_global_kset)
> 		return -ENOMEM;
> 
> 	return sysfs_create_group(&zpci_global_kset->kobj, &zpci_attr_group_global);

Huge hint, if in a driver, or bus subsystem, and you call sysfs_*,
that's usually a huge clue that you are doing something wrong.

Try the above again, with a simple attribute group, and name for it, and
it should "just work".

thanks,

greg k-h
